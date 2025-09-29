package com.aichatsy.app

import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Base64
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import android.provider.Settings.Secure


class MainActivity : FlutterActivity() {


    private val CHANNEL = "com.aichatsy.app/hashKey"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getHashKey") {
                val hashKey = getHashKey()
                if (hashKey != null) {
                    result.success(hashKey)
                } else {
                    result.error("UNAVAILABLE", "Hash key not available.", null)
                }
            } else if (call.method == "getDeviceID") {
                val deviceID = getDeviceID()
                if (deviceID != null) {
                    result.success(deviceID)
                } else {
                    result.error("UNAVAILABLE", "DeviceID not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }


    private fun getHashKey(): String? {
//        try {
//            val info: PackageInfo = packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
//            for (signature in info.signatures) {
//                val md: MessageDigest = MessageDigest.getInstance("SHA")
//                md.update(signature.toByteArray())
//                return Base64.encodeToString(md.digest(), Base64.DEFAULT)
//            }
//        } catch (e: PackageManager.NameNotFoundException) {
//            e.printStackTrace()
//        } catch (e: NoSuchAlgorithmException) {
//            e.printStackTrace()
//        }
        return null
    }

    private fun getDeviceID(): String? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
            Secure.getString(contentResolver, Secure.ANDROID_ID)
        } else {
            ""
        }
    }

}

