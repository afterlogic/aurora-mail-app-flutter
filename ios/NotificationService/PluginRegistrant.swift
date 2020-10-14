//
//  PluginRegistrant.swift
//  NotificationService
//
//  Created by Alexander Orlov on 13.10.2020.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//
import Flutter
import receive_sharing
import sqflite
import shared_preferences
import path_provider
import flutter_secure_storage
import firebase_crashlytics

 class PluginRegistrant {
     static func register(_ with:FlutterEngine){
        SqflitePlugin.register(with: with.registrar(forPlugin: "SqflitePlugin")!)
        FLTSharedPreferencesPlugin.register(with: with.registrar(forPlugin: "FLTSharedPreferencesPlugin")!)
        FLTPathProviderPlugin.register(with: with.registrar(forPlugin: "FLTPathProviderPlugin")!)
        FlutterSecureStoragePlugin.register(with: with.registrar(forPlugin: "FlutterSecureStoragePlugin")!)
        FirebaseCrashlyticsPlugin.register(with: with.registrar(forPlugin: "FirebaseCrashlyticsPlugin")!)
    }
}
