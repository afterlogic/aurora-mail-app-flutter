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
    var notification:[String:AnyObject]?=nil
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        if #available(iOS 13.0, *) {
            BGTaskScheduler.shared.register(
                forTaskWithIdentifier: "com.afterlogic.background.notification",
                using: nil) { (task) in
                    self.handleAppRefreshTask(task: task)
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        let notificationOption = launchOptions?[.remoteNotification]
        if let notification = notificationOption as? [String:AnyObject]{
            self.notification=notification
            if #available(iOS 13.0, *) {
                scheduleBackgroundFetch()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.handleAppRefreshTask(task: nil)
                }
            }
        }
        return  super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: userInfo,fetchCompletionHandler: completionHandler)
    }
    
    @available(iOS 13.0, *)
    func handleAppRefreshTask(task: BGTask?) {
        task?.expirationHandler={
            self.notification = nil
            task?.setTaskCompleted(success: false)
        }
        if(notification==nil){


            task?.setTaskCompleted(success: true)
        }else{
            SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: notification!,fetchCompletionHandler: {_ in
                task?.setTaskCompleted(success: true)
            })
            self.notification = nil
        }
    }
    @available(iOS 13.0, *)
    func scheduleBackgroundFetch() {
        let fetchTask = BGAppRefreshTaskRequest(identifier: "com.afterlogic.background.notification")
        fetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 1)
        do {
            try BGTaskScheduler.shared.submit(fetchTask)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
    override func applicationDidEnterBackground(_ application: UIApplication) {
        if #available(iOS 13.0, *) {
            scheduleBackgroundFetch()
        }
    }
}
