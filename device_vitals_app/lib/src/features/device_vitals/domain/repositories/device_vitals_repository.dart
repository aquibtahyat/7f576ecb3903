import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';

abstract interface class DeviceVitalsRepository {
  Future<Result<ThermalStateEntity>> getThermalState();
  Future<Result<BatteryLevelEntity>> getBatteryLevel();
  Future<Result<MemoryUsageEntity>> getMemoryUsage();
}
