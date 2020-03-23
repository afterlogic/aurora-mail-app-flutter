import 'package:encrypt/encrypt.dart';

class CryptoUtil {
  static String createSymmetricKey([int length = 10, bool recursive = false]) {
    var base64 = SecureRandom(length).base64;
    if (recursive) {
      base64 = base64.substring(0, base64.length - 2);
    }
    return base64.replaceAllMapped(
      RegExp("[^a-zA-Z0-9]"),
      (match) {
        return createSymmetricKey(1, true)[0];
      },
    );
  }
}
