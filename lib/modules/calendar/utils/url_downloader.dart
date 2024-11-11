import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/utils/download_directory.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

Future downloadFromUrl(
    {required String url, required User user, required String fileName}) async {

  try{
    await getStoragePermissions();
    final module = new WebMailApi(
      moduleName: WebMailModules.calendar,
      hostname: user.hostname,
      token: user.token,
      interceptor: DefaultApiInterceptor.get(),
    );

    final headers = await module.getAuthHeaders();
    final downloadsDirectory = await getDownloadDirectory();

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: downloadsDirectory,
      fileName: '${fileName}.ics',
      saveInPublicStorage: true,
      headers: headers as Map<String, String>,
    );
  }catch (e, st){
    print(e);
  }
}