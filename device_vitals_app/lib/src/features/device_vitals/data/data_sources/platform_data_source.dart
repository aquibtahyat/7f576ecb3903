import 'package:device_vitals_app/src/features/device_vitals/data/models/battery_level_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/memory_usage_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/thermal_state_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlatformDataSource {
  static const _channel = MethodChannel('com.example.device_vitals');

  Future<ThermalStateModel> getThermalStatus() async {
    final result = await _channel.invokeMethod<int>('getThermalStatus');

    return ThermalStateModel(value: result);
  }

  Future<BatteryLevelModel> getBatteryLevel() async {
    final result = await _channel.invokeMethod<int>('getBatteryLevel');

    return BatteryLevelModel(batteryLevel: result);
  }

  Future<MemoryUsageModel> getMemoryUsage() async {
    final result = await _channel.invokeMethod<int>('getMemoryUsage');

    return MemoryUsageModel(memoryUsage: result);
  }
}
