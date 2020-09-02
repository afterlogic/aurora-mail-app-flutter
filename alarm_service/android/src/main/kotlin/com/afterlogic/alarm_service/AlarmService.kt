package com.afterlogic.alarm_service

import android.app.IntentService
import android.app.Notification
import android.content.Intent
import android.os.AsyncTask
import android.os.Build
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.FlutterNativeView
import android.os.Looper
import android.os.Handler
import android.util.Log
import io.flutter.view.FlutterMain
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.view.FlutterRunArguments
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

    override fun onHandleIntent(intent: Intent) {
        val entryPoint = intent.getStringExtra(AlarmBroadcast.ENTRY_POINT)
        val libraryPath = intent.getStringExtra(AlarmBroadcast.LIBRARY_PATH)
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
                    FlutterMain.ensureInitializationComplete(application, null)
                    val mAppBundlePath = FlutterMain.findAppBundlePath()
                    val flutter = SoftReference(FlutterNativeView(this, true))
                    val args = FlutterRunArguments()
                    args.bundlePath = mAppBundlePath
                    args.entrypoint = entryPoint
                    args.libraryPath = libraryPath
                    flutter.get()?.apply {
                        runFromBundle(args)
                        onStartFlutter(this.pluginRegistry)
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


    abstract fun onStartFlutter(registry: PluginRegistry)

    abstract fun createNotification(): Notification

    companion object {
        private const val NOTIFICATION_ID = 4856
    }
}
