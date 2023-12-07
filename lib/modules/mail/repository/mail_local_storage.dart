import 'dart:io';

import 'package:aurora_mail/utils/permissions.dart';
import 'package:file_picker/file_picker.dart';

class MailLocalStorage {
  Future<File> pickFile({FileType type = FileType.any}) async {
    await getStoragePermissions();
    FilePicker.platform.clearTemporaryFiles();
    return FilePicker.platform
        .pickFiles(type: type ?? FileType.any)
        .then((value) => value != null ? File(value.files.first.path) : null);
  }
}
