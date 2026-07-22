
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/widgets.dart';

class MailAttachment {
  static final currentlyDownloadingAttachments = <DownloadTaskProgress>[];

  static StreamSubscription<TaskUpdate>? _subscription;

  // background_downloader delivers updates for every enqueued task on a
  // single global stream, so we only ever need one listener for the
  // lifetime of the app; it dispatches to whichever DownloadTaskProgress
  // matches the update's taskId.
  static void _ensureListening() {
    if (_subscription != null) return;
    _subscription = FileDownloader().updates.listen((update) async {
      final id = update.task.taskId;
      final task = currentlyDownloadingAttachments
          .firstWhereOrNull((da) => da.taskId == id);
      if (task == null) return;

      if (update is TaskStatusUpdate) {
        if (update.status.isFinalState) {
          await task.finish(update.status);
        }
      } else if (update is TaskProgressUpdate) {
        task.updateProgress(update.progress, TaskStatus.running);
      }
    });
  }

  final String? fileName;
  final String? mimeType;
  final String? mimePartIndex;
  final int? size;
  final String? contentLocation;
  final String? location;
  final String? cid;
  final bool? isInline;
  final bool? isLinked;
  final String? hash;
  final String? viewUrl;
  final String? downloadUrl;
  final String? thumbnailUrl;

  MailAttachment({
    required this.fileName,
    required this.mimeType,
    required this.mimePartIndex,
    required this.size,
    required this.contentLocation,
    required this.location,
    required this.cid,
    required this.isInline,
    required this.isLinked,
    required this.hash,
    required this.viewUrl,
    required this.downloadUrl,
    required this.thumbnailUrl,
  });

  Function()? _onDownloadEnd;
  Function()? _onError;

  add(DownloadTask task, String destinationPath,
      Function({required String taskId}) cancel) {
    currentlyDownloadingAttachments.add(new DownloadTaskProgress(
      task: task,
      destinationPath: destinationPath,
      attachmentHash: hash,
      cancel: cancel,
      onEnd: _onDownloadEnd,
      onError: _onError,
    ));
  }

  Future<void> startDownload({
    required Function() onDownloadStart,
    required Function() onDownloadEnd,
    required Function() onError,
  }) async {
    _onDownloadEnd = onDownloadEnd;
    _onError = onError;
    _ensureListening();
    onDownloadStart();
  }

  void endDownloading(String taskId) {
    final process = currentlyDownloadingAttachments
        .firstWhereOrNull((da) => da.taskId == taskId);
    if (process != null) {
      process.endProcess();
      currentlyDownloadingAttachments.removeWhere((da) => da.taskId == taskId);
    }
  }

  DownloadTaskProgress? getDownloadTask() {
    return currentlyDownloadingAttachments
        .firstWhereOrNull((da) => da.attachmentHash == hash);
  }

  static List<MailAttachment> fromJsonString(String? jsonString) {
    if (jsonString == null) return [];
    final attachments = json.decode(jsonString) as Map;

    final collection = attachments["@Collection"] as List?;

    if (collection == null || collection.isEmpty) return [];

    return collection.map((item) {
      return new MailAttachment(
        fileName: item["FileName"] as String?,
        mimeType: item["MimeType"] as String?,
        mimePartIndex: item["MimePartIndex"] as String?,
        size: item["EstimatedSize"] as int?,
        cid: item["CID"] as String?,
        contentLocation: item["ContentLocation"] as String?,
        location: item["Content"] as String?,
        isInline: item["IsInline"] as bool?,
        isLinked: item["IsLinked"] as bool?,
        hash: item["Hash"] as String?,
        viewUrl: item["Actions"] is Map
            ? item["Actions"]["view"]["url"] as String?
            : null,
        downloadUrl: item["Actions"] is Map
            ? item["Actions"]["download"]["url"] as String?
            : null,
        thumbnailUrl: item["ThumbnailUrl"] as String?,
      );
    }).toList();
  }
}

class DownloadTaskProgress {
  final DownloadTask task;
  // final absolute path the rest of the app expects the downloaded file at;
  // background_downloader (this version) can only download into one of its
  // fixed BaseDirectory locations, so the task saves to a private staging
  // location and this is where it's moved to once complete.
  final String? destinationPath;
  final String? attachmentHash;
  final Function({required String taskId}) cancel;
  final Function()? onEnd;
  final Function()? onError;
  TaskStatus? _status;

  String get taskId => task.taskId;

  TaskStatus? get status => _status;

  // kept as an int 0-100 (rather than background_downloader's 0.0-1.0
  // double) so the existing progress UI doesn't need to change.
  int? _currentProgress;
  final _controller = new StreamController<int?>.broadcast();

  int? get currentProgress => _currentProgress;

  Stream<int?> get progressStream => _controller.stream.asBroadcastStream();

  void updateProgress(double progress, TaskStatus status) {
    _currentProgress = (progress.clamp(0, 1) * 100).round();
    _status = status;
    _controller.sink.add(_currentProgress);
  }

  Future<void> finish(TaskStatus status) async {
    var finalStatus = status;
    if (status == TaskStatus.complete && destinationPath != null) {
      try {
        final tempPath = await task.filePath();
        await File(destinationPath!).parent.create(recursive: true);
        await File(tempPath).copy(destinationPath!);
        await File(tempPath).delete();
      } catch (e) {
        finalStatus = TaskStatus.failed;
      }
    }
    updateProgress(finalStatus == TaskStatus.complete ? 1.0 : 0.0, finalStatus);
    if (finalStatus == TaskStatus.complete) {
      onEnd?.call();
    } else {
      onError?.call();
    }
  }

  void endProcess() {
    _controller.close();
    cancel(taskId: taskId);
  }

  DownloadTaskProgress({
    required this.task,
    this.destinationPath,
    required this.attachmentHash,
    required this.cancel,
    this.onEnd,
    this.onError,
  });
}
