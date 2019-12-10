package com.afterlogic.background_service_example

import android.app.Notification
import android.os.Build
import com.afterlogic.alarm_service.AlarmService
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class AppService : AlarmService() {
    override fun createNotification(): Notification {
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, App.NOTIFICATION_CHANNEL_ID)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this)
        }.apply {
            setSmallIcon(android.R.mipmap.sym_def_app_icon)
            setContentTitle("Update mail")
            setContentText("...")
        }
        return builder.build()
    }

    override fun onStartFlutter(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

}