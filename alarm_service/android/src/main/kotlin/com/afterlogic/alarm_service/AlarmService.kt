package com.afterlogic.alarm_service

import android.app.IntentService
import android.app.Notification
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor.DartCallback
import io.flutter.view.FlutterCallbackInformation
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
                    val flutterLoader = FlutterInjector.instance().flutterLoader()
                    flutterLoader.startInitialization(applicationContext)
                    flutterLoader.ensureInitializationComplete(applicationContext, null)
                    val mAppBundlePath = flutterLoader.findAppBundlePath()

                    flutter = SoftReference(FlutterEngine(applicationContext))
                    if (flutter != null) {
                        flutter?.get()?.apply {
                            if (callbackId != null) {
                                val flutterCallback = FlutterCallbackInformation.lookupCallbackInformation(callbackId)
                                if (flutterCallback != null) {
                                    val dartCallback = DartCallback(applicationContext.resources.assets, mAppBundlePath, flutterCallback)
                                    if (dartCallback != null) {
                                        this.dartExecutor.executeDartCallback(dartCallback)
                                    }
                                } 
                            }
                            if (this != null) {
                                onStartFlutter(this) 
                            }
                        }
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
