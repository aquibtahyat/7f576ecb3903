import 'package:device_vitals_app/hive_registrar.g.dart';
import 'package:device_vitals_app/src/core/constants/app_constants.dart';
import 'package:device_vitals_app/src/core/services/cache/cache_manager.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_unique_id_model.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CacheManager)
class CacheManagerImpl extends CacheManager {
  CacheManagerImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    if (!Hive.isAdapterRegistered(0) || !Hive.isAdapterRegistered(1)) {
      Hive.registerAdapters();
    }
    if (!Hive.isBoxOpen(AppConstants.logBox) ||
        !Hive.isBoxOpen(AppConstants.deviceBox)) {
      await Hive.openBox<CachedDeviceVitalsRequestModel>(AppConstants.logBox);
      await Hive.openBox<CachedUniqueIdModel>(AppConstants.deviceBox);
    }
  }

  Future<Box<CachedDeviceVitalsRequestModel>> _getLogBox() async {
    await _initBox();
    return Hive.box<CachedDeviceVitalsRequestModel>(AppConstants.logBox);
  }

  Future<Box<CachedUniqueIdModel>> _getDeviceBox() async {
    await _initBox();
    return Hive.box<CachedUniqueIdModel>(AppConstants.deviceBox);
  }

  @override
  Future<String> saveLog(CachedDeviceVitalsRequestModel vitalsLog) async {
    final box = await _getLogBox();
    final key = DateTime.parse(vitalsLog.timestamp).toUtc().toIso8601String();
    await box.put(key, vitalsLog);

    return key;
  }

  @override
  Future<List<CachedDeviceVitalsRequestModel>> getAllLogs() async {
    final box = await _getLogBox();
    return box.values.toList();
  }

  @override
  Future<CachedDeviceVitalsRequestModel?> getLog(String key) async {
    final box = await _getLogBox();
    return box.get(key);
  }

  @override
  Future<void> removeLog(String key) async {
    final box = await _getLogBox();
    await box.delete(key);
  }

  @override
  Future<void> clearLogs() async {
    final box = await _getLogBox();
    await box.clear();
  }

  @override
  Future<String?> getUniqueId(CacheKey key) async {
    final box = await _getDeviceBox();
    final id = box.get(key.name)?.uniqueId;

    return (id == null || id.isEmpty) ? null : id;
  }

  @override
  Future<void> saveUniqueId(CacheKey key, String value) {
    final box = _getDeviceBox();
    return box.then(
      (b) => b.put(key.name, CachedUniqueIdModel(uniqueId: value)),
    );
  }
}
