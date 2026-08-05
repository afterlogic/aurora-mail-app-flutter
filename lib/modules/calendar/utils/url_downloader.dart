import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:aurora_mail/utils/shared_storage.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

// onDownloaded takes the saved file's path rather than a BuildContext so
// callers can show a confirmation (e.g. a SnackBar) without depending on a
// context that might already be gone by the time the download finishes --
// e.g. the calendar drawer closes itself right after the tap, since an open
// Drawer renders above the Scaffold's SnackBar and would otherwise hide it.
Future downloadFromUrl({
  required String url,
  required User user,
  required String fileName,
  void Function(String path)? onDownloaded,
}) async {

  try{
    await getStoragePermissions();
    final module = new WebMailApi(
      moduleName: WebMailModules.calendar,
      hostname: user.hostname,
      token: user.token,
      interceptor: DefaultApiInterceptor.get(),
    );

    final headers = await module.getAuthHeaders();

    // downloaded to a private staging location first, then moved into the
    // public Downloads folder (mirrors flutter_downloader's
    // saveInPublicStorage: true)
    final task = DownloadTask(
      url: url,
      filename: '${fileName}.ics',
      baseDirectory: BaseDirectory.temporary,
      headers: headers,
    );
    final result = await FileDownloader().download(task);
    if (result.status == TaskStatus.complete) {
      final path = await moveToDownloads(File(await task.filePath()));
      onDownloaded?.call(path);
    }
  }catch (e){
    print(e);
  }
}
