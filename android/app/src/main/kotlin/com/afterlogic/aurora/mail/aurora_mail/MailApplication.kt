package com.afterlogic.aurora.mail.aurora_mail

import android.app.Notification
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
            if (notificationManager.getNotificationChannel(OLD_NOTIFICATION_MAIL_CHANNEL_ID) != null) {
                for (item in notificationManager.notificationChannels) {
                    notificationManager.deleteNotificationChannel(item.id)
                }
            }
            if (notificationManager.getNotificationChannel(NOTIFICATION_SYNC_CHANNEL_ID) == null) {
                val name = "Background"
                val descriptionText = "background update"
                val importance = NotificationManager.IMPORTANCE_LOW

                val mChannel = NotificationChannel(NOTIFICATION_SYNC_CHANNEL_ID, name, importance)
                mChannel.lockscreenVisibility = Notification.VISIBILITY_SECRET
                mChannel.description = descriptionText
                notificationManager.createNotificationChannel(mChannel)
            }
            if (notificationManager.getNotificationChannel(NOTIFICATION_MAIL_CHANNEL_ID) == null) {
                val importance = NotificationManager.IMPORTANCE_HIGH

                val mChannel = NotificationChannel(NOTIFICATION_MAIL_CHANNEL_ID, NOTIFICATION_MAIL_CHANNEL_NAME, importance)
                mChannel.lockscreenVisibility = Notification.VISIBILITY_PUBLIC
                mChannel.description = NOTIFICATION_MAIL_CHANNEL_DESCRIPTION
                notificationManager.createNotificationChannel(mChannel)
            }
        }
    }

    companion object {
        const val NOTIFICATION_SYNC_CHANNEL_ID = "background"
        const val OLD_NOTIFICATION_MAIL_CHANNEL_ID = "new_mail"
        const val NOTIFICATION_MAIL_CHANNEL_ID = "default"
        const val NOTIFICATION_MAIL_CHANNEL_NAME = "Default"
        const val NOTIFICATION_MAIL_CHANNEL_DESCRIPTION = ""
    }
}