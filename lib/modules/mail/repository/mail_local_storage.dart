import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MailLocalStorage {
  Future<File> pickFile({FileType type = FileType.any}) async {
    return FilePicker.getFile(type: type);
  }
}
