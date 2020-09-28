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
import ios_notification_handler
@UIApplicationMain
class AppDelegate: FlutterAppDelegate{
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        GeneratedPluginRegistrant.register(with: self)
        let notificationOption = launchOptions?[.remoteNotification]
        if let notification = notificationOption as? [String:AnyObject],let aps = notification["aps"] as? [String:AnyObject]{
            SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: notification,fetchCompletionHandler: {_ in })
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: userInfo,fetchCompletionHandler: completionHandler)
    }
}
