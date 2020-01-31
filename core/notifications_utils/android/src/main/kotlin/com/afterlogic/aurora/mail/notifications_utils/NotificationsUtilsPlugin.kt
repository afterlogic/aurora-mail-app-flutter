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
import io.flutter.plugin.common.PluginRegistry.Registrar


/** NotificationsUtilsPlugin */
class NotificationsUtilsPlugin(private val context: Context) : FlutterPlugin, MethodCallHandler {

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "notifications_utils")
        channel.setMethodCallHandler(NotificationsUtilsPlugin(flutterPluginBinding.applicationContext))
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "notifications_utils")
            channel.setMethodCallHandler(NotificationsUtilsPlugin(registrar.context()))
        }
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
