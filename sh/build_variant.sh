#!/usr/bin/env bash
flutter pub get
flutter pub run build_variant $1
flutter pub get
flutter pub run flutter_launcher_icons:main
flutter pub run build_runner build --delete-conflicting-outp uts