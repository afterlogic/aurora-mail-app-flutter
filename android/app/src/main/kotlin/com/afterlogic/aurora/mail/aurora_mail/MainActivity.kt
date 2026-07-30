package com.afterlogic.aurora.mail.aurora_mail

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.Environment
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.firebase.Firebase
import com.google.firebase.app
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

class MainActivity : FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        // A workaround for installing the "firebase_app_check" debug-token.
        // Until the possibility of installing it from Flutter is implemented:
        // https://github.com/firebase/flutterfire/pull/16942
        // Source: https://stackoverflow.com/questions/76162520/how-to-setup-firebase-app-check-debug-tokens-for-real-device-while-testing-acros

        //TODO: Think about optimizing so that this code is not called every time the activity is recreated.

        val debugToken = BuildConfig.FIREBASE_APP_CHECK_DEBUG_TOKEN
        println("!!! onCreate FIREBASE_APP_CHECK_DEBUG_TOKEN: $debugToken")
        if (debugToken != "") {
            val firebaseApp = Firebase.app
            val prefs = context.getSharedPreferences(
                "com.google.firebase.appcheck.debug.store.${firebaseApp.persistenceKey}",
                Context.MODE_PRIVATE,
            )
            prefs.edit().putString(
                "com.google.firebase.appcheck.debug.DEBUG_SECRET",
                debugToken,
            ).apply()
        }

        super.onCreate(savedInstanceState)
        requestNotificationPermissionIfNeeded()
    }

    private fun requestNotificationPermissionIfNeeded() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
            return
        }

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                REQUEST_CODE_NOTIFICATION,
            )
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "DIRECTORY_DOWNLOADS").setMethodCallHandler { call, result ->
            result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).path)
        }
        //todo fix permission_handler on android 10
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "REQUEST_STORAGE_PERMISSION").setMethodCallHandler { call, result ->
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
            awaitResult = null
        } else if (requestCode == REQUEST_CODE_NOTIFICATION) {
            // Notification permission result is ignored here; the foreground service will use the channel settings.
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
        const val REQUEST_CODE_NOTIFICATION = 529
        const val PERMISSION_GRANTED = 1
    }
}
