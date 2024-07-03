import 'package:webmail_api_client/webmail_api_client.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingsNetwork{
  final WebMailApi settingsModule;

  const SettingsNetwork({required this.settingsModule});

  Future<tz.Location> getTimezoneLocation() async{
    final body = new WebMailApiBody(
      method: "GetAppData",
      parameters: null,
    );

    final response = await settingsModule.post(body);
    final result = tz.getLocation(response["Core"]["Timezone"] as String);
    return result;
  }
}