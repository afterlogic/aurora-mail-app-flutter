//
//  NotificationService.swift
//  NotificationService
//
//  Created by Alexander Orlov on 13.10.2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//
import Flutter
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        let flutter=FlutterEngine.init()
        flutter.run(withEntrypoint: "notificationService")
        
        PluginRegistrant.register(flutter)
        NotificationServicePlugin.register(with: flutter.registrar(forPlugin: "NotificationServicePlugin")!)
        NotificationServicePlugin.instance?.bestAttemptContent = bestAttemptContent
        NotificationServicePlugin.instance?.contentHandler = contentHandler
        
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            bestAttemptContent.title="TimeOut"
            contentHandler(bestAttemptContent)
        }
    }
    
}
class NotificationServicePlugin:NSObject, FlutterPlugin {
    var bestAttemptContent: UNMutableNotificationContent?
    var contentHandler:  ((UNNotificationContent) -> Void)?
    static var instance :NotificationServicePlugin?
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "notification_service_plugin", binaryMessenger: registrar.messenger())
        instance = NotificationServicePlugin()
        registrar.addMethodCallDelegate(instance!, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arg = call.arguments as? [Any]
        do {
            switch call.method {
            case "getNotification":
                let map = bestAttemptContent.debugDescription;
                result(map)
                return
            case "showNotification":
                //bestAttemptContent?.userInfo=["payload":arg?[0] as? String]
                bestAttemptContent?.title=arg?[0] as? String ?? ":("
                contentHandler?(bestAttemptContent!)
                result(arg)
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
}
