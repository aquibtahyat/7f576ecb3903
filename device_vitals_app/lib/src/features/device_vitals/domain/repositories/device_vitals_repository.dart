import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';

abstract interface class DeviceVitalsRepository {
  Future<Result<ThermalStateEntity>> getThermalState();
  Future<Result<BatteryLevelEntity>> getBatteryLevel();
  Future<Result<MemoryUsageEntity>> getMemoryUsage();
  Future<Result<void>> logDeviceVitals({
    required DeviceVitalsRequestEntity request,
  });
  Future<Result<List<DeviceVitalsEntity>>> getDeviceVitalsHistory({
    int limit = 100,
  });
  Future<Result<DeviceVitalsAnalyticsEntity>> getDeviceVitalsAnalytics({
    required DateRange dateRange,
  });
  Future<Result<bool>> getAutoLogPreference();
  Future<Result<bool>> changeAutoLogPreference({required bool value});
}
