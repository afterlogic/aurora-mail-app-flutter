package com.afterlogic.aurora.mail.aurora_mail

import android.app.Notification
import android.os.Build
import com.afterlogic.alarm_service.AlarmService
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine

class AppService : AlarmService() {
    override fun createNotification(): Notification {
        @Suppress("DEPRECATION")
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, MailApplication.NOTIFICATION_CHANNEL_ID)
        } else {
            Notification.Builder(this)
        }.apply {
            //todo VO
            setSmallIcon(R.mipmap.ic_launcher)
            setContentTitle("Update mail")
            setContentText("...")
        }
        return builder.build()
    }

    override fun startApp(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

}