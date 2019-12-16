package com.afterlogic.alarm_service

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class AlarmBroadcast : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val app = (context.applicationContext as WithAlarm)
        try {
            val serviceIntent = Intent(context, app.clazzService)

            serviceIntent.putExtra(ENTRY_POINT, intent.getStringExtra(ENTRY_POINT))
            serviceIntent.putExtra(LIBRARY_PATH, intent.getStringExtra(LIBRARY_PATH))
            serviceIntent.putExtra(ID, intent.getIntExtra(ID, -1))

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(serviceIntent)
            } else {
                context.startService(serviceIntent)
            }
        } catch (e: Throwable) {
            Log.e("flutter alarm service", "$e")
        }
    }

    companion object {
        fun setAlarm(context: Context,
                     dartEntryPoint: String,
                     libraryPath: String,
                     id: Int,
                     secondDelay: Int,
                     repeat: Boolean) {
            val intent = Intent(context, AlarmBroadcast::class.java)

            intent.putExtra(DELAY, secondDelay)
            intent.putExtra(ENTRY_POINT, dartEntryPoint)
            intent.putExtra(LIBRARY_PATH, libraryPath)
            intent.putExtra(ID, id)

            val pendingIntent = PendingIntent.getBroadcast(context, id, intent, 0)
            val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager

            val interval = secondDelay * 1000L
            if (repeat) {
                alarmManager.setRepeating(
                        AlarmManager.RTC_WAKEUP,
                        System.currentTimeMillis() + interval,
                        interval,
                        pendingIntent
                )
            } else {
                alarmManager.set(
                        AlarmManager.RTC_WAKEUP,
                        System.currentTimeMillis() + interval,
                        pendingIntent
                )
            }
        }

        fun cancelAlarm(context: Context, id: Int) {
            val intent = Intent(context, AlarmBroadcast::class.java)
            val pendingIntent = PendingIntent.getBroadcast(context, id, intent, 0)
            val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
            alarmManager.cancel(pendingIntent)
        }

        private const val DELAY = "delay"
        const val ENTRY_POINT = "entryPoint"
        const val LIBRARY_PATH = "libraryPath"
        const val ID = "id"
    }
}