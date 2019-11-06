import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MailLocalStorage {
  Future<File> pickFile() async {
    return FilePicker.getFile();
  }
}