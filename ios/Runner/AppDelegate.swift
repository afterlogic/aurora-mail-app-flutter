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
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
