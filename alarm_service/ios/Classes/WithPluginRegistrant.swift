//
//  WithPluginRegistrant.swift
//  alarm_service
//
//  Created by Alexander Orlov on 29.01.2020.
//

import Foundation
import Flutter

public protocol WithPluginRegistrant {
    
    func register(_ flutter:FlutterEngine)
}
