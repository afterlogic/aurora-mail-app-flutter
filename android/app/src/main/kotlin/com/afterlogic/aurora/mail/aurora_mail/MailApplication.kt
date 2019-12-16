package com.afterlogic.aurora.mail.aurora_mail

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import com.afterlogic.alarm_service.WithAlarm

internal class MailApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback, WithAlarm {
    override val clazzService = AppService::class.java

    override fun registerWith(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (notificationManager.getNotificationChannel(NOTIFICATION_CHANNEL_ID) == null) {
                val name = "background"
                val descriptionText = "background update"
                val importance = NotificationManager.IMPORTANCE_LOW

                val mChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, name, importance)
                mChannel.description = descriptionText
                notificationManager?.createNotificationChannel(mChannel)
            }
        }
    }

    companion object {
        const val NOTIFICATION_CHANNEL_ID = "background"
    }
}