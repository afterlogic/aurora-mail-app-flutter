//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

const _DOWNLOAD_PORT_NAME = "downloader_send_port";

class MailAttachment {
  static final currentlyDownloadingAttachments =
      new List<DownloadTaskProgress>();

  final String fileName;
  final String mimeType;
  final String mimePartIndex;
  final int size;
  final String contentLocation;
  final String location;
  final String cid;
  final bool isInline;
  final bool isLinked;
  final String hash;
  final String viewUrl;
  final String downloadUrl;
  final String thumbnailUrl;

  MailAttachment({
    @required this.fileName,
    @required this.mimeType,
    @required this.mimePartIndex,
    @required this.size,
    @required this.contentLocation,
    @required this.location,
    @required this.cid,
    @required this.isInline,
    @required this.isLinked,
    @required this.hash,
    @required this.viewUrl,
    @required this.downloadUrl,
    @required this.thumbnailUrl,
  });

  add(String taskId, Function({String taskId}) cancel) {
    currentlyDownloadingAttachments.add(new DownloadTaskProgress(
      taskId: taskId,
      attachmentHash: hash,
      cancel: cancel,
    ));
  }

  Future<void> startDownload({
    @required Function() onDownloadStart,
    @required Function() onDownloadEnd,
    @required Function() onError,
  }) async {
    final port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _DOWNLOAD_PORT_NAME,
    );
    port.listen((data) {
      String id = data[0] as String;
      DownloadTaskStatus status = DownloadTaskStatus(data[1] as int);
      int progress = data[2] as int;
      if ([
        DownloadTaskStatus.complete,
        DownloadTaskStatus.failed,
        DownloadTaskStatus.canceled
      ].contains(status)) {
        onDownloadEnd();
        endDownloading(id);
      } else {
        final task = currentlyDownloadingAttachments
            .firstWhere((da) => da.taskId == id, orElse: () => null);

        task?.updateProgress(progress, status);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
    onDownloadStart();
  }

  void endDownloading(String taskId) {
    final process = currentlyDownloadingAttachments
        .firstWhere((da) => da.taskId == taskId, orElse: () => null);
    if (process != null) {
      process.endProcess();
      currentlyDownloadingAttachments.removeWhere((da) => da.taskId == taskId);
    }
    IsolateNameServer.removePortNameMapping(_DOWNLOAD_PORT_NAME);
  }

  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    print("Not called");

    ///Status 4 - error
    final SendPort send =
        IsolateNameServer.lookupPortByName(_DOWNLOAD_PORT_NAME);
    send.send([id, status, progress]);
  }

  DownloadTaskProgress getDownloadTask() {
    return currentlyDownloadingAttachments
        .firstWhere((da) => da.attachmentHash == hash, orElse: () => null);
  }

  static List<MailAttachment> fromJsonString(String jsonString) {
    if (jsonString == null) return [];
    final attachments = json.decode(jsonString) as Map;

    final collection = attachments["@Collection"] as List;

    if (collection == null || collection.isEmpty) return [];

    return collection.map((item) {
      return new MailAttachment(
        fileName: item["FileName"] as String,
        mimeType: item["MimeType"] as String,
        mimePartIndex: item["MimePartIndex"] as String,
        size: item["EstimatedSize"] as int,
        cid: item["CID"] as String,
        contentLocation: item["ContentLocation"] as String,
        location: item["Content"] as String,
        isInline: item["IsInline"] as bool,
        isLinked: item["IsLinked"] as bool,
        hash: item["Hash"] as String,
        viewUrl: item["Actions"] is Map
            ? item["Actions"]["view"]["url"] as String
            : null,
        downloadUrl: item["Actions"] is Map
            ? item["Actions"]["download"]["url"] as String
            : null,
        thumbnailUrl: item["ThumbnailUrl"] as String,
      );
    }).toList();
  }
}

class DownloadTaskProgress {
  final String taskId;
  final String attachmentHash;
  final Function({String taskId}) cancel;
  DownloadTaskStatus _status;

  DownloadTaskStatus get status => _status;

  int _currentProgress;
  final _controller = new StreamController<int>.broadcast();

  int get currentProgress => _currentProgress;

  Stream<int> get progressStream => _controller.stream.asBroadcastStream();

  void updateProgress(int num, DownloadTaskStatus status) {
    _currentProgress = num;
    _status = status;
    _controller.sink.add(num);
  }

  void endProcess() {
    _controller.close();
    cancel(taskId: taskId);
  }

  DownloadTaskProgress({
    @required this.taskId,
    @required this.attachmentHash,
    @required this.cancel,
  });
}
