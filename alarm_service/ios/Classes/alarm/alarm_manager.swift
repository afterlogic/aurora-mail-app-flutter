//
//  alarm_manager.swift
//  alarm_service
//
//  Created by Alexander Orlov on 18.12.2019.
//

import Foundation
import UserNotifications

class AlarmManager{
    static let notificationName=NSNotification.Name.init(rawValue: "alarm")
    
    
    static func setAlarm(_ entryPoint:String,_ libPath:String,_ id:NSNumber,_ time:NSNumber,_ repeat:Bool){

    }

    static func cancelAlarm(_ id:NSNumber){
        
    }
}
