//
//  NotificationService.swift
//  NotificationService
//
//  Created by Alexander Orlov on 18.12.2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//
import UIKit
import UserNotifications
import CoreData
import Flutter
import alarm_service

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNNotificationContent?
    
    
    override open func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.bestAttemptContent = request.content
        self.contentHandler = contentHandler
        runFetch()
    }
    
    static var runInApp=false
    
    func runFetch(){
        
        let appNotification = CFNotificationName("com.afterlogic.aurora.mail.auroraMail" as CFString)
        let serviceNotification = CFNotificationName("com.afterlogic.aurora.mail.auroraMail.service" as CFString)
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterPostNotification(notificationCenter, appNotification, nil, nil, false)
        
        NotificationService.runInApp = false
        NotificationService.endCallback = nil
        CFNotificationCenterAddObserver(
            notificationCenter,
            nil,
            {(
                center: CFNotificationCenter?,
                observer: UnsafeMutableRawPointer?,
                name: CFNotificationName?,
                object: UnsafeRawPointer?,
                userInfo: CFDictionary?
                ) in
                NotificationService.runInApp=true
        },
            serviceNotification.rawValue,
            nil,
            CFNotificationSuspensionBehavior.deliverImmediately
        )
        
        sleep(1)
        
        if(!NotificationService.runInApp){
            startFlutter()
        }else{
            self.contentHandler!(self.bestAttemptContent!)
        }
    }
    
    func startFlutter(){
        
        if(NotificationService.flutterEngine==nil){
            let userDefaults = UserDefaults.init(suiteName: "group.support.afterlogic.alarm")!
            let entryPoint = userDefaults.string(forKey: "dartEntryPoint")
            let libUri = userDefaults.string(forKey: "dartLibraryUri")
            
            NotificationService.flutterEngine = FlutterEngine(name: "background_work", project:  FlutterDartProject.init(), allowHeadlessExecution: true)
            NotificationService.flutterEngine!.run(withEntrypoint: entryPoint, libraryURI: libUri)
            
            GeneratedPluginRegistrant.register(with: NotificationService.flutterEngine!)
            
            let alarmNotification = CFNotificationName("SwiftAlarmPlugin.endAlarm" as CFString)
            let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
            
            NotificationService.endCallback = self.serviceExtensionTimeWillExpire
            
            CFNotificationCenterAddObserver(
                notificationCenter,
                nil,
                {(
                    center: CFNotificationCenter?,
                    observer: UnsafeMutableRawPointer?,
                    name: CFNotificationName?,
                    object: UnsafeRawPointer?,
                    userInfo: CFDictionary?
                    ) in
                    NotificationService.endCallback?()
            },
                alarmNotification.rawValue,
                nil,
                CFNotificationSuspensionBehavior.deliverImmediately
            )
        }
        
    }
    
    override open func serviceExtensionTimeWillExpire() {
        if(NotificationService.flutterEngine != nil){
            NotificationService.flutterEngine?.destroyContext()
            NotificationService.flutterEngine = nil
        }
        NotificationService.endCallback=nil
    }
    static var flutterEngine: FlutterEngine?
    static var endCallback: (()-> Void)?
}
