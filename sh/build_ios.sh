flutter pub get
flutter build ios
xcodebuild clean archive -workspace ios/Runner.xcworkspace -scheme Runner -archivePath ios/RunnerArchive
xcodebuild -exportArchive -archivePath ios/RunnerArchive.xcarchive -exportOptionsPlist ios/ExportOptions.plist -exportPath ./build