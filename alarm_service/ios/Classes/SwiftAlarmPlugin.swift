import Flutter
import UIKit

public class SwiftAlarmPlugin: NSObject, FlutterPlugin {
    let userDefaults=UserDefaults()
    var onEndAlarm: ((Bool) -> Void)?=nil
    var onAlarm:FlutterResult?=nil
    
    var interval:Double?{
        set { userDefaults.set(newValue, forKey: SwiftAlarmPlugin.interalKey) }
        get { return userDefaults.double(forKey: SwiftAlarmPlugin.interalKey) }
    }
    var callbackName:String?{
        set { userDefaults.set(newValue, forKey: SwiftAlarmPlugin.callbackNameKey) }
        get { return userDefaults.string(forKey: SwiftAlarmPlugin.callbackNameKey) }
    }
    var callbackLibraryPath:String?{
        set { userDefaults.set(newValue, forKey: SwiftAlarmPlugin.callbackLibraryPathKey) }
        get { return userDefaults.string(forKey: SwiftAlarmPlugin.callbackLibraryPathKey) }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let arg = call.arguments as? [Any]
        do {
            switch call.method {
            case "setAlarm":
                let callback = FlutterCallbackCache.lookupCallbackInformation((arg![0] as! NSNumber).int64Value)
                setAlarm(
                    callback!.callbackName,
                    callback!.callbackLibraryPath,
                    arg![2] as! NSNumber
                )
                result("")
                return
            case "endAlarm":
                endAlarm(hasData: arg![0] as! Bool)
                result("")
                return
            case "removeAlarm":
                removeAlarm()
                result("")
                return
            case "doOnAlarm":
                onAlarm = result
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
    
    func setAlarm(_ callbackName:String,
                  _ callbackLibraryPath:String,
                  _ interval:NSNumber){
        self.interval=interval.doubleValue
        self.callbackName=callbackName
        self.callbackLibraryPath=callbackLibraryPath
        updateFetch()
    }
    
    func removeAlarm(){
        interval=nil
        updateFetch()
    }
    
    func endAlarm(hasData:Bool){
        if onEndAlarm != nil {
            onEndAlarm!(hasData)
            onEndAlarm = nil
        }
    }
    
    open func alarm(_ application: UIApplication,_ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        var timer:Timer?
        onEndAlarm = {(hasData) in
            timer?.invalidate()
            completionHandler(hasData ? UIBackgroundFetchResult.newData : UIBackgroundFetchResult.noData)
        }
        if onAlarm == nil {
            onAlarm?(-1)
            onAlarm=nil
            timer=Timer.scheduledTimer(timeInterval: 80, target: self, selector: #selector(timeOut), userInfo: nil, repeats: false)
        } else{
            onEndAlarm?(false)
        }
    }
    
    @objc func timeOut() {
        if onEndAlarm != nil {
            onEndAlarm!(false)
        }
    }
    
    func updateFetch(){
        var interval = self.interval ?? UIApplicationBackgroundFetchIntervalNever
        if interval != UIApplicationBackgroundFetchIntervalNever && interval < UIApplicationBackgroundFetchIntervalMinimum {
            interval = UIApplicationBackgroundFetchIntervalMinimum
        }
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(interval)
    }
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        alarm(application,completionHandler)
        return true
    }
    
    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        alarm(application,completionHandler)
        return true
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        updateFetch()
        return true
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "alarm_service", binaryMessenger: registrar.messenger())
        let plugin = SwiftAlarmPlugin()
        registrar.addApplicationDelegate(plugin)
        registrar.addMethodCallDelegate(plugin, channel: channel)
    }
    static let interalKey = "FetchIntervalKey"
    static let callbackNameKey = "CallbackNameKey"
    static let callbackLibraryPathKey = "CallbackLibraryPathKey"
}
