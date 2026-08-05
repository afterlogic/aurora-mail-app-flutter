import 'package:aurora_mail/build_property.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

abstract class AppCheckRepository {
  Future<String> getToken();
}

class AppCheckRepositoryImpl implements AppCheckRepository {
  @override
  Future<String> getToken() async {
    if (!BuildProperty.enableAppCheck) {
      return '';
    }

    String token = '';
    try {
      token = await FirebaseAppCheck.instance.getToken() ?? '';
      debugPrint('AppCheckRepository.getToken(): $token');
    } catch (e) {
      debugPrint('AppCheckRepository.getToken(): $e');
    }

    return token;
  }
}
