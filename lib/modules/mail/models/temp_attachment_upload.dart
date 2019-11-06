import 'package:flutter/cupertino.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:uuid/uuid.dart';

class TempAttachmentUpload {
  final String guid = new Uuid().v4();
  final String name;
  final int size;
  final String taskId;
  final Stream<UploadTaskProgress> uploadProgress;
  final Function({String taskId}) cancel;

  TempAttachmentUpload({
    @required this.name,
    @required this.size,
    @required this.taskId,
    @required this.uploadProgress,
    @required this.cancel,
  });
}
