import Flutter
import UIKit
import BackgroundTasks

public class SwiftAlarmPlugin: NSObject, FlutterPlugin {
    let userDefaults=UserDefaults()
    var onEndAlarm: ((Bool) -> Void)?=nil
    var onAlarm:FlutterResult?=nil
    var hasAlarm = false
    
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
                if hasAlarm {
                    hasAlarm=false
                    result(-1)
                    onAlarm=nil
                }else{
                    onAlarm = result
                }
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
        updateAppRefresh()
    }
    
    func removeAlarm(){
        interval=nil
        updateAppRefresh()
    }
    
    func endAlarm(hasData:Bool){
        if onEndAlarm != nil {
            onEndAlarm!(hasData)
            onEndAlarm = nil
        }
    }
    
    open func alarm(didReceiveRemoteNotification userInfo: [AnyHashable : Any]?=nil,_ completionHandler: @escaping (Bool) -> Void) {
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
            hasAlarm=true
        }
        timer=Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(timeOut), userInfo: nil, repeats: false)
    }
    
    @objc func timeOut() {
        if onEndAlarm != nil {
            onEndAlarm!(false)
        }
    }
    
    func alarmFromFetch(_ completionHandler: @escaping (UIBackgroundFetchResult) -> Void,didReceiveRemoteNotification userInfo: [AnyHashable : Any]?=nil){
        alarm(didReceiveRemoteNotification: userInfo,{(hasData) in
            completionHandler(hasData ? UIBackgroundFetchResult.newData : UIBackgroundFetchResult.noData)
        })
    }
    
    @available(iOS 13.0, *)
    func alarmFromTask(_ task:BGTask){
        alarm{(hasData) in
            task.setTaskCompleted(success: true)
        }
        updateAppRefresh()
    }
    
    func updateAppRefresh(){
        var interval = self.interval ?? UIApplication.backgroundFetchIntervalNever
        if interval != UIApplication.backgroundFetchIntervalNever && interval < UIApplication.backgroundFetchIntervalMinimum {
            interval = UIApplication.backgroundFetchIntervalMinimum
        }
        
        if #available(iOS 13.0, *) {
            do {
                if(interval == UIApplication.backgroundFetchIntervalNever){
                    BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: SwiftAlarmPlugin.taskId)
                }else{
                    let request = BGAppRefreshTaskRequest(identifier: SwiftAlarmPlugin.taskId)
                    request.earliestBeginDate = Date(timeIntervalSinceNow: interval)
                    try BGTaskScheduler.shared.submit(request)
                }
            } catch {
                UIApplication.shared.setMinimumBackgroundFetchInterval(interval)
            }
        } else {
            UIApplication.shared.setMinimumBackgroundFetchInterval(interval)
        }
    }
    
    @available(iOS 13.0, *)
    func registerTask(){
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: SwiftAlarmPlugin.taskId,
            using: DispatchQueue.global(),
            launchHandler: {(task) in
                self.alarmFromTask(task)
        }
        )
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        alarmFromFetch(completionHandler,didReceiveRemoteNotification: userInfo)
        return true
    }
    
    public func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        alarmFromFetch(completionHandler)
        return true
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        if #available(iOS 13.0, *) {
            registerTask()
        }
        updateAppRefresh()
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
    static let taskId="com.afterlogic.background.task"
}
