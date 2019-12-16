package com.afterlogic.background_service_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import com.afterlogic.alarm_service.WithAlarm
import io.flutter.app.FlutterApplication

class App : FlutterApplication(), WithAlarm {
    override val clazzService = AppService::class.java

    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as? NotificationManager
            if (notificationManager?.getNotificationChannel(NOTIFICATION_CHANNEL_ID) == null) {
                val name = "sample"
                val descriptionText = "chanel for sample"
                val importance = NotificationManager.IMPORTANCE_LOW
                val mChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID, name, importance)
                mChannel.description = descriptionText
                notificationManager?.createNotificationChannel(mChannel)
            }
        }
    }

    companion object {
        const val NOTIFICATION_CHANNEL_ID = "main"
    }
}