import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_device_vitals_request_model.dart';

abstract class CacheManager {
  Future<String> saveLog(CachedDeviceVitalsRequestModel vitalsLog);

  Future<List<CachedDeviceVitalsRequestModel>> getAllLogs();

  Future<CachedDeviceVitalsRequestModel?> getLog(String key);

  Future<void> removeLog(String key);

  Future<void> clearLogs();
}
