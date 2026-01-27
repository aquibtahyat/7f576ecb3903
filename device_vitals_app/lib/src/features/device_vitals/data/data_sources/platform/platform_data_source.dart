import 'package:device_vitals_app/src/core/constants/app_constants.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/battery_level_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/memory_usage_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/thermal_state_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlatformDataSource {
  static final _channel = MethodChannel(AppConstants.methodChannel);

  Future<ThermalStateModel> getThermalStatus() async {
    final result = await _channel.invokeMethod<int>(
      AppConstants.getThermalStateMethod,
    );

    return ThermalStateModel(value: result);
  }

  Future<BatteryLevelModel> getBatteryLevel() async {
    final result = await _channel.invokeMethod<int>(
      AppConstants.getBatteryLevelMethod,
    );

    return BatteryLevelModel(batteryLevel: result);
  }

  Future<MemoryUsageModel> getMemoryUsage() async {
    final result = await _channel.invokeMethod<int>(
      AppConstants.getMemoryUsageMethod,
    );

    return MemoryUsageModel(memoryUsage: result);
  }
}
