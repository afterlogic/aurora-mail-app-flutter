import UIKit
import Flutter
import CoreData
import UserNotifications
import NotificationCenter
import BackgroundTasks
import UserNotifications
import alarm_service


@UIApplicationMain
class AppDelegate: FlutterAppDelegate{
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initNotification(application: application)
        serviceObserver()
      
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func serviceObserver(){
        let appNotification = CFNotificationName("com.afterlogic.aurora.mail.auroraMail" as CFString)
        
        CFNotificationCenterAddObserver(
            CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            {(
                center: CFNotificationCenter?,
                observer: UnsafeMutableRawPointer?,
                name: CFNotificationName?,
                object: UnsafeRawPointer?,
                userInfo: CFDictionary?
                ) in
                SwiftAlarmPlugin.instance?.alarm()
                
                let serviceNotification = CFNotificationName("com.afterlogic.aurora.mail.auroraMail.service" as CFString)
                let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
                CFNotificationCenterPostNotification(notificationCenter, serviceNotification, nil, nil, false)
        },
            appNotification.rawValue,
            nil,
            CFNotificationSuspensionBehavior.deliverImmediately
        )
    }
    
    
    
    func initNotification(application: UIApplication){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge,.alert,.sound])
            {(granted, error) in
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        
        print("Device Token: \(token)")
        UserDefaults.standard.set(token,forKey: "deviceToken")
    }
}
