import 'package:aurora_mail/models/app_data.dart';
import 'package:webmail_api_client/webmail_api_client.dart';

class SettingsNetwork{
  final WebMailApi settingsModule;

  const SettingsNetwork({required this.settingsModule});

  Future<AppData> getSettings() async{
    final body = new WebMailApiBody(
      method: "GetAppData",
      parameters: null,
    );

    final response = await settingsModule.post(body);
    final result = AppData.fromMap(response["Core"] as Map<String, dynamic>);
    return result;
  }
}