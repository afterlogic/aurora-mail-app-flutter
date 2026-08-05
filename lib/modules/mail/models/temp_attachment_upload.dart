
import 'dart:io';

import 'package:uuid/uuid.dart';

class UploadProgress {
  final String taskId;
  // 0.0-1.0, or a negative value if the upload failed/was cancelled
  final double progress;

  const UploadProgress(this.taskId, this.progress);
}

class TempAttachmentUpload {
  final String guid = new Uuid().v4();
  final String name;
  int? size;
  final String taskId;
  final Stream<UploadProgress> uploadProgress;
  final Function({String? taskId}) cancel;
  final File? file;

  TempAttachmentUpload(
    this.file, {
    required this.name,
    required this.size,
    required this.taskId,
    required this.uploadProgress,
    required this.cancel,
  });
}
