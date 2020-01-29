import UIKit
import Flutter
import alarm_service

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, WithPluginRegistrant {
    
    func register(_ flutter: FlutterEngine) {
        GeneratedPluginRegistrant.register(with: flutter)
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
