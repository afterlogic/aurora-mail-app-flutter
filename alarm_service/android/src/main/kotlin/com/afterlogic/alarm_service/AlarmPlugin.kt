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
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class AlarmPlugin : MethodCallHandler, FlutterPlugin{

    private var applicationContext: Context? = null
    private var methodChannel: MethodChannel? = null

    companion object {
        var onComplete: (() -> Unit)? = null
        var isBackground: Boolean = false
        var instance: AlarmPlugin? = null
    }

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        this.applicationContext = binding.applicationContext
        methodChannel = MethodChannel(binding.binaryMessenger, "alarm_service")
        methodChannel!!.setMethodCallHandler(this)
        instance = this
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        applicationContext = null
        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
        instance = null
    }


    private var doOnAlarm: Result? = null

    override fun onMethodCall(call: MethodCall, result: Result) {
        val arg = call.arguments as List<*>?
        try {
            when {
                call.method == "setAlarm" -> {
                    AlarmBroadcast.setAlarm(applicationContext!!,
                            (arg!![0] as Number).toLong(),
                            (arg[1] as Number).toInt(),
                            (arg[2] as Number).toLong())
                    result.success("")
                }
                call.method == "removeAlarm" -> {
                    doOnAlarm?.success(null)
                    AlarmBroadcast.cancelAlarm(applicationContext!!, arg!![0] as Int)
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
