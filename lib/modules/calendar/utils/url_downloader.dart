import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/settings/screens/debug/default_api_interceptor.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:background_downloader/background_downloader.dart';
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

    // downloaded to a private staging location first, then moved into the
    // public Downloads folder (mirrors flutter_downloader's
    // saveInPublicStorage: true)
    final task = DownloadTask(
      url: url,
      filename: '${fileName}.ics',
      baseDirectory: BaseDirectory.temporary,
      headers: headers as Map<String, String>,
    );
    final result = await FileDownloader().download(task);
    if (result.status == TaskStatus.complete) {
      await FileDownloader()
          .moveFileToSharedStorage(await task.filePath(), SharedStorage.downloads);
    }
  }catch (e, st){
    print(e);
  }
}