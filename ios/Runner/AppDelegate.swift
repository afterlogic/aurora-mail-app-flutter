import UIKit
import Flutter
import CoreData
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,FlutterPlugin {
    var backgroundTask:UIBackgroundTaskIdentifier?=nil
    
    func register() {
        let channel = FlutterMethodChannel(name: "ios_alarm_manager", binaryMessenger:self.messenger())
         registrar.addMethodCallDelegate(self, channel: channel)
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    register()
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method=call.method
        let arg=call.arguments as? [Any]
        switch method {
        case "cancel":
            //todo
            break
        case "periodic":
            let interval = arg![0] as! NSNumber
            let callbackId = arg![1] as! NSNumber
        
            let callback  = FlutterCallbackCache.lookupCallbackInformation(callbackId.int64Value)!;
      
            //todo
            break
        default:
            result(FlutterMethodNotImplemented)
        }

    }
    
    func onAlarm(entryPoint:String,libraryPath:String){
        let engine = FlutterEngine.init(name: "alarm", project: nil,allowHeadlessExecution:false)
        engine?.run(withEntrypoint: entryPoint, libraryURI: libraryPath)
        
        GeneratedPluginRegistrant.register(with: engine)
    }
    
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    //
    // Integration note:
    //
    // In Flutter, in order to work in background isolate, plugins need to register with
    // a special instance of `FlutterEngine` that serves for background execution only.
    // Hence, all (and only) plugins that require background execution feature need to
    // call `register` in this function.
    //
    // The default `GeneratedPluginRegistrant` will call `register` of all plugins integrated
    // in your application. Hence, if you are using `FlutterDownloaderPlugin` along with other
    // plugins that need UI manipulation, you should register `FlutterDownloaderPlugin` and any
    // 'background' plugins explicitly like this:
    //
    // FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "vn.hunghd.flutter_downloader"))
    //
    GeneratedPluginRegistrant.register(with: registry)
}
