package com.afterlogic.aurora.mail.aurora_mail

import io.flutter.app.FlutterApplication
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import com.afterlogic.alarm_service.WithAlarm


internal class MailApplication : FlutterApplication(), WithAlarm {
    override val clazzService = AppService::class.java


    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (notificationManager.getNotificationChannel(NOTIFICATION_SYNC_CHANNEL_ID) == null) {
                val name = "Background"
                val descriptionText = "background update"
                val importance = NotificationManager.IMPORTANCE_LOW

                val mChannel = NotificationChannel(NOTIFICATION_SYNC_CHANNEL_ID, name, importance)
                mChannel.description = descriptionText
                notificationManager?.createNotificationChannel(mChannel)
            }
            if (notificationManager.getNotificationChannel(NOTIFICATION_MAIL_CHANNEL_ID) == null) {
                val importance = NotificationManager.IMPORTANCE_HIGH

                val mChannel = NotificationChannel(NOTIFICATION_MAIL_CHANNEL_ID, NOTIFICATION_MAIL_CHANNEL_NAME, importance)
                mChannel.description = NOTIFICATION_MAIL_CHANNEL_DESCRIPTION
                notificationManager?.createNotificationChannel(mChannel)
            }
        }
    }

    companion object {
        const val NOTIFICATION_SYNC_CHANNEL_ID = "background"
        const val NOTIFICATION_MAIL_CHANNEL_ID = "new_mail"
        const val NOTIFICATION_MAIL_CHANNEL_NAME = "New mail"
        const val NOTIFICATION_MAIL_CHANNEL_DESCRIPTION = ""
    }
}