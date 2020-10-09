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
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: FlutterAppDelegate{
    let enableDebugLog=true
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        application.registerForRemoteNotifications()
        GeneratedPluginRegistrant.register(with: self)
        debugNotification("App running")
        let version = UIDevice.current.systemVersion
        let iosVersion = NSString(string: version).doubleValue
        if (iosVersion >= 13 && iosVersion < 14) {
            let notificationOption = launchOptions?[.remoteNotification]
            if let notification = notificationOption as? [String:AnyObject]{
                debugNotification("notification showing from swift")
                showNotification(notification)
            }
        }
        
        return  super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func getStateName(_ state:UIApplication.State)->String{
        switch state {
        case .active :
            return "active"
        case .inactive :
            return "inactive"
        case .background :
            return "background"
        }
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.debugNotification("notification sent to flutter in \(getStateName(UIApplication.shared.applicationState))")
        SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: userInfo,fetchCompletionHandler: completionHandler)
    }
    
    func showNotification(_ notification :[String:AnyObject]){
        let notificationCenter = UNUserNotificationCenter.current()
        let identifier = notification["To"] as? String ?? ""
        let content = UNMutableNotificationContent()
        content.userInfo=["payload":notification["To"] as? String ?? ""]
        content.title = notification["From"] as? String ?? ""
        content.body = notification["Subject"] as? String ?? ""
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    func debugNotification(_ text:String){
        if(!enableDebugLog){
            return
        }
        let notificationCenter = UNUserNotificationCenter.current()
        let identifier = text
        let content = UNMutableNotificationContent()
        content.title = "Debug Log"
        content.body = text
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
}
