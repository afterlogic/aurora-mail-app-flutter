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
    var messageCallback:  FlutterResult?
    var finishMessageCallback: ((UIBackgroundFetchResult) -> Void)?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
