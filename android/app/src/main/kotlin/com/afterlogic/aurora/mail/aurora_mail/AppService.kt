package com.afterlogic.aurora.mail.aurora_mail

import android.app.Notification
import android.os.Build
import com.afterlogic.alarm_service.AlarmService
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class AppService : AlarmService() {
    override fun createNotification(): Notification {
        @Suppress("DEPRECATION")
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, MailApplication.NOTIFICATION_SYNC_CHANNEL_ID)
        } else {
            Notification.Builder(this)
        }.apply {
            //todo VO
            setSmallIcon(R.drawable.app_icon)
            setContentTitle("Mail syncing...")
            setProgress(0, 0, true);
        }
        return builder.build()
    }

    override fun onStartFlutter(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

}