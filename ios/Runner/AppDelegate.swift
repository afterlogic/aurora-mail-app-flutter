import UIKit
import Flutter
import CoreData
import UserNotifications
import NotificationCenter
import BackgroundTasks
import UserNotifications
import alarm_service
import Firebase
import receive_sharing

@UIApplicationMain
class AppDelegate: FlutterAppDelegate{
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
