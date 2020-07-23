package com.afterlogic.alarm_service

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.view.FlutterCallbackInformation

class AlarmPlugin(private val applicationContext: Context) : MethodCallHandler {
    companion object {
        var onComplete: (() -> Unit)? = null
        var isBackground: Boolean = false
        var instance: AlarmPlugin? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "alarm_service")
            if (instance == null)
                instance = AlarmPlugin(registrar.context().applicationContext)
            channel.setMethodCallHandler(instance)
            registrar.addViewDestroyListener {
                instance = null
                true
            }
        }
    }

    private var doOnAlarm: Result? = null

    override fun onMethodCall(call: MethodCall, result: Result) {
        val arg = call.arguments as List<*>?
        try {
            when {
                call.method == "setAlarm" -> {
                    val callbackId = arg!![0] as Long
                    val callback = FlutterCallbackInformation.lookupCallbackInformation(callbackId)
                    AlarmBroadcast.setAlarm(applicationContext,
                            callback.callbackName,
                            callback.callbackLibraryPath,
                            arg[1] as Int,
                            (arg[2] as Number).toLong())
                    result.success("")
                }
                call.method == "removeAlarm" -> {
                    doOnAlarm?.success(null)
                    AlarmBroadcast.cancelAlarm(applicationContext, arg!![0] as Int)
                    result.success("")
                }
                call.method == "endAlarm" -> {
                    onComplete?.invoke()
                    result.success("")
                }
                call.method == "doOnAlarm" -> {
                    doOnAlarm = result
                }
                else -> result.notImplemented()
            }
        } catch (e: Throwable) {
            e.printStackTrace()
            result.error(e.toString(), e.message, null)
        }
    }

    fun onAlarm(onComplete: () -> Unit, id: Int) {
        Handler(Looper.getMainLooper()).post {
            try {
                doOnAlarm?.success(id)
            } catch (e: Throwable) {
                e.printStackTrace()
            }
        }
        onComplete.invoke()
    }
}
