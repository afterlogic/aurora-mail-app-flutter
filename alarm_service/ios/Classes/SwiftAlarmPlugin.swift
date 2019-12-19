import Flutter
import UIKit

public class SwiftAlarmPlugin: NSObject, FlutterPlugin {
    
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
                AlarmManager.cancelAlarm( arg![0] as! NSNumber)
                result("")
                return
            case "isAlarm":
                result(SwiftAlarmPlugin.isBackground)
                return
            case "endAlarm":
                SwiftAlarmPlugin.onCompleteAlarm?()
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
    
    func alarm(onComplete: () -> Void, id: Int) {
        onAlarm?(id)
        onAlarm=nil
        onComplete()
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: "alarm_service", binaryMessenger: registrar.messenger())
      let instance = SwiftAlarmPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel)
      
    }
    
    static var onCompleteAlarm:(()->Void)?=nil
    static var instanse:SwiftAlarmPlugin?=nil
    static var isBackground: Bool = false
}
