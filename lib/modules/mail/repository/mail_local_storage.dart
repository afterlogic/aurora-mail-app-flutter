import 'dart:io';
import 'package:file_picker/file_picker.dart';

class MailLocalStorage {
  Future<List<File>> pickFiles({FileType type = FileType.any}) async {
    await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult pickerResult = await FilePicker.platform.pickFiles(type: type, allowMultiple: true);
    return pickerResult == null ? [] : pickerResult.files.map((e) => File(e.path)).toList();
  }
}
