package com.afterlogic.aurora.mail.aurora_mail

import android.app.Notification
import android.content.Intent
import android.os.Build
import com.afterlogic.alarm_service.AlarmService
import io.flutter.app.FlutterPluginRegistry
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class AppService : AlarmService() {

    override fun onStartFlutter(registry: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(registry)
    }


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


}