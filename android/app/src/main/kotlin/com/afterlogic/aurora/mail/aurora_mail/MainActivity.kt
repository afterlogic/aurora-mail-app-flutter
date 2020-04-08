package com.afterlogic.aurora.mail.aurora_mail

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.Environment
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, "DIRECTORY_DOWNLOADS").setMethodCallHandler { call, result ->
            result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).path)
        }
        //todo fix permission_handler on android 10
        MethodChannel(flutterView, "REQUEST_STORAGE_PERMISSION").setMethodCallHandler { call, result ->
            val notGranted = permissions.firstOrNull { ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED }
            if (notGranted != null) {
                awaitResult = result
                ActivityCompat.requestPermissions(
                        this,
                        permissions,
                        REQUEST_CODE)
            } else {
                result.success(true)
            }
        }

    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if (requestCode == REQUEST_CODE) {
            val notGranted = grantResults.firstOrNull { it != PackageManager.PERMISSION_GRANTED }
            awaitResult?.success(notGranted == null)
        } else {
            super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        }
    }

    companion object {
        var awaitResult: MethodChannel.Result? = null
        val permissions = arrayOf(
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.READ_EXTERNAL_STORAGE)
        const val REQUEST_CODE = 528
        const val PERMISSION_GRANTED = 1
    }
}
