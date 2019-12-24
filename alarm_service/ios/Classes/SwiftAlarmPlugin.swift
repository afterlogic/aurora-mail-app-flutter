import Flutter
import UIKit

open class SwiftAlarmPlugin: NSObject, FlutterPlugin {
    
    var onAlarm:FlutterResult?=nil
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let arg = call.arguments as? [Any]
        do {
            switch call.method {
            case "setAlarm":
                let callback = FlutterCallbackCache.lookupCallbackInformation((arg![0] as! NSNumber).int64Value)
                AlarmManager.setAlarm(
                    callback!.callbackName,
                    callback!.callbackLibraryPath,
                    arg![1] as! NSNumber,
                    arg![2] as! NSNumber,
                    arg![3] as! Bool
                )
                result("")
                return
            case "cancelAlarm":
                onAlarm?(nil)
                onAlarm=nil
                AlarmManager.cancelAlarm( arg![0] as! NSNumber)
                result("")
                return
            case "isAlarm":
                result("SwiftAlarmPlugin.isBackground")
                return
            case "endAlarm":
                let serviceNotification = CFNotificationName("SwiftAlarmPlugin.endAlarm" as CFString)
                let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
                CFNotificationCenterPostNotification(notificationCenter, serviceNotification, nil, nil, false)
                result("")
                return
            case "doOnAlarm":
                onAlarm=result
                return
            default:
                result(FlutterMethodNotImplemented)
                return
            }
        } catch let e {
            print(e.localizedDescription)
            result(FlutterMethodNotImplemented)
        }
    }
    
    open func alarm() {
        onAlarm?(752)//from flutter
        onAlarm=nil
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "alarm_service", binaryMessenger: registrar.messenger())
        let plugin = SwiftAlarmPlugin()
        registrar.addMethodCallDelegate(plugin, channel: channel)
        instance = plugin
    }
    
    public static weak var instance:SwiftAlarmPlugin? = nil
}
