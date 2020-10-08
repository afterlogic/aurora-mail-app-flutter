import Flutter
import UIKit

public class SwiftIosNotificationHandlerPlugin: NSObject, FlutterPlugin {
   public static var instance:SwiftIosNotificationHandlerPlugin?=nil
    var onEndAlarm: ((Bool) -> Void)?=nil
    var onAlarm:FlutterResult?=nil
    var hasAlarm = false
    var userInfo: [AnyHashable : Any]?=nil
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_notification_handler", binaryMessenger: registrar.messenger())
        if(instance == nil){
            instance = SwiftIosNotificationHandlerPlugin()
        }
        
        registrar.addApplicationDelegate(instance!)
        registrar.addMethodCallDelegate(instance!, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arg = call.arguments as? [Any]
        do {
            switch call.method {
            case "isBackground":
                UIApplication.State.active
                result(UIApplication.shared.applicationState.rawValue)
            case "listen":
                if hasAlarm {
                    hasAlarm=false
                    result(userInfo)
                    onAlarm=nil
                }else{
                    onAlarm = result
                }
                return
            case "finish":
                endAlarm(hasData: (arg![0] as? Bool) ?? false)
                result("")
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
    func endAlarm(hasData:Bool){
        if onEndAlarm != nil {
            onEndAlarm!(hasData)
            onEndAlarm = nil
        }
    }
    
    open func onNotification(didReceiveRemoteNotification userInfo: [AnyHashable : Any]?=nil,_ completionHandler: @escaping (Bool) -> Void) {
        var timer:Timer?
        onEndAlarm = {(hasData) in
            self.hasAlarm=false
            timer?.invalidate()
            completionHandler(hasData)
        }
        if onAlarm != nil {
            onAlarm?(userInfo)
            onAlarm=nil
        } else{
            self.userInfo=userInfo
            hasAlarm=true
        }
        timer=Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(timeOut), userInfo: nil, repeats: false)
    }
    
    @objc func timeOut() {
        if onEndAlarm != nil {
            onEndAlarm!(false)
        }
    }
    
    static public func reciveNotification(didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        instance?.onNotification(didReceiveRemoteNotification: userInfo,{(hasData) in
            completionHandler(hasData ? UIBackgroundFetchResult.newData : UIBackgroundFetchResult.noData)
        })
    }
}
