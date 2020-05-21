package com.afterlogic.aurora.mail.aurora_mail

import android.Manifest
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.os.Environment
import android.os.StrictMode
import android.webkit.MimeTypeMap
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.core.content.FileProvider.getUriForFile
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        val builder: StrictMode.VmPolicy.Builder = StrictMode.VmPolicy.Builder()
        StrictMode.setVmPolicy(builder.build())
        builder.detectFileUriExposure()
        MethodChannel(flutterView, "DIRECTORY_DOWNLOADS").setMethodCallHandler { call, result ->
            result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).path)
        }
        MethodChannel(flutterView, "open_file").setMethodCallHandler { call, result ->
            result.success(openFile(call.arguments as String))
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

    private fun openFile(filename: String): Boolean {
        val context: Context = this
        try {
            val file = File(filename)
            val uri = getUriForFile(context, applicationContext.packageName + ".file-provider", file)
            val intent = Intent(Intent.ACTION_VIEW)
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            intent.setDataAndType(uri, getMimeType(filename))
            context.startActivity(intent)
            return true
        } catch (e: Throwable) {
            e
        }
        val file = File(filename);
        val uri = Uri.fromFile(file)
        val intent = Intent(Intent.ACTION_VIEW)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        intent.setDataAndType(uri, getMimeType(filename))
        return try {
            context.startActivity(intent)
            true
        } catch (e: ActivityNotFoundException) {
            false
        }
    }

    private fun getMimeType(filename: String): String? {
        val extension = MimeTypeMap.getFileExtensionFromUrl(filename)
        if (extension != null) {
            return MimeTypeMap.getSingleton().getMimeTypeFromExtension(extension)
        }
        return null
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
class  MyFileProvider : FileProvider()