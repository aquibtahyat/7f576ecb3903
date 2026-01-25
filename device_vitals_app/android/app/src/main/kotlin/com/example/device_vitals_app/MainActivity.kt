package com.example.device_vitals_app

import androidx.annotation.NonNull
import android.app.ActivityManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.PowerManager


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.device_vitals"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    try {
                        val batteryLevel = getBatteryLevel()
                        if (batteryLevel != -1) {
                            result.success(batteryLevel)
                        } else {
                            result.error("FAIL", "Battery level not available", null)
                        }
                    } catch (e: Exception) {
                        result.error("FAIL", "Battery error: ${e.message}", null)
                    }
                }

                "getMemoryUsage" -> {
                    try {
                        val memoryPercent = getMemoryUsage()
                        if (memoryPercent >= 0) {
                            result.success(memoryPercent)
                        } else {
                            result.error("FAIL", "Memory info not available", null)
                        }
                    } catch (e: Exception) {
                        result.error("FAIL", "Memory error: ${e.message}", null)
                    }
                }

                "getThermalStatus" -> {
                    try {
                        val thermalStatus = getThermalStatus()
                        if (thermalStatus >= 0) {
                            result.success(thermalStatus)
                        } else {
                            result.error("FAIL", "Thermal status not available", null)
                        }
                    } catch (e: Exception) {
                        result.error("FAIL", "Thermal error: ${e.message}", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
        }

        return batteryLevel
    }

    private fun getMemoryUsage(): Int {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)

        val totalMemory = memoryInfo.totalMem.toDouble()
        val availableMemory = memoryInfo.availMem.toDouble()
        val usedMemory = totalMemory - availableMemory
        val percentage = (usedMemory / totalMemory) * 100

        return percentage.toInt()
    }

    private fun getThermalStatus(): Int {
        if (VERSION.SDK_INT >= VERSION_CODES.Q) {
            val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
            return when (powerManager.currentThermalStatus) {
                PowerManager.THERMAL_STATUS_NONE -> 0
                PowerManager.THERMAL_STATUS_LIGHT -> 1
                PowerManager.THERMAL_STATUS_MODERATE -> 2
                PowerManager.THERMAL_STATUS_SEVERE,
                PowerManager.THERMAL_STATUS_CRITICAL,
                PowerManager.THERMAL_STATUS_EMERGENCY -> 3

                else -> 3
            }
        }
        return -1
    }
}
