package com.afterlogic.alarm_service

import android.app.IntentService
import android.app.Notification
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor.DartCallback
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain
import java.lang.ref.SoftReference
import kotlin.system.exitProcess


abstract class AlarmService : IntentService("Check update mail") {
    private var flutter: SoftReference<FlutterEngine>? = null

    override fun onCreate() {
        super.onCreate()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForeground(NOTIFICATION_ID, createNotification())
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        flutter?.get()?.destroy()
        flutter?.clear()
        val isBackground = AlarmPlugin.isBackground
        if (isBackground) {
            AlarmPlugin.instance = null
            AlarmPlugin.isBackground = false
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            stopForeground(true)
        }
        if (isBackground) {
            exitProcess(0)
        }
    }


    override fun onHandleIntent(intent: Intent?) {
        intent ?: return
        val callbackId = intent.getLongExtra(AlarmBroadcast.CALLBACK_ID, -1)
        val id = intent.getIntExtra(AlarmBroadcast.ID, -1)

        val onComplete = {
            stopSelf()
        }
        if (AlarmPlugin.instance != null) {
            AlarmPlugin.instance!!.onAlarm(onComplete, id)
        } else {

            AlarmPlugin.isBackground = true
            AlarmPlugin.onComplete = onComplete
            Handler(Looper.getMainLooper()).post {
                try {
                    FlutterMain.startInitialization(applicationContext)
                    FlutterMain.ensureInitializationComplete(applicationContext, null)
                    val mAppBundlePath = FlutterMain.findAppBundlePath()

                    flutter = SoftReference(FlutterEngine(applicationContext))
                    flutter?.get()?.apply {
                        val flutterCallback = FlutterCallbackInformation.lookupCallbackInformation(callbackId)
                        val dartCallback = DartCallback(applicationContext.resources.assets, mAppBundlePath, flutterCallback)
                        this.dartExecutor.executeDartCallback(dartCallback)
                        onStartFlutter(this)
                    }
                } catch (e: Throwable) {
                    Log.e("flutter alarm service", "$e")
                }
            }
            //todo timeout
            /** todo service cancel after end [onHandleIntent] **/
            Thread.sleep(120000)
        }
    }


    abstract fun onStartFlutter(registry: FlutterEngine)

    abstract fun createNotification(): Notification

    companion object {
        private const val NOTIFICATION_ID = 4856
    }
}
