package com.afterlogic.aurora.mail.notifications_utils

import android.app.NotificationManager
import android.content.Context
import android.content.Context.NOTIFICATION_SERVICE
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** NotificationsUtilsPlugin */
class NotificationsUtilsPlugin() : FlutterPlugin, MethodCallHandler {
    lateinit var context: Context;
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notifications_utils")
        val plugin = NotificationsUtilsPlugin();
        plugin.context = flutterPluginBinding.applicationContext;
        channel.setMethodCallHandler(plugin)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getActiveNotifications") {
            getActiveNotifications(result)
        } else {
            result.notImplemented()
        }
    }

    private fun getActiveNotifications(result: Result) {
        if (Build.VERSION.SDK_INT < 23) {
            result.success(null)
        } else {
            val notificationManager: NotificationManager = context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            val activeNotifications = notificationManager.activeNotifications
            val notifications = activeNotifications.map {
                val map = HashMap<String, Any?>()
                map["packageName"] = it.packageName
                map["id"] = it.id
                map["tag"] = it.tag
                map["postTime"] = it.postTime
                map["groupKey"] = it.groupKey
                map["flags"] = it.notification.flags
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    map["isGroup"] = it.isGroup
                }
                map
            }

            result.success(notifications)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

}
