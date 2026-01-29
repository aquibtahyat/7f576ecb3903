import 'package:device_vitals_app/src/core/base/repository.dart';
import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/services/cache/cache_manager.dart';
import 'package:device_vitals_app/src/core/services/device/device_info.dart';
import 'package:device_vitals_app/src/core/services/time/time_service.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/platform/platform_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/remote/remote_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/battery_level_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/device_vitals_analytics_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/device_vitals_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/device_vitals_request_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/memory_usage_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/thermal_state_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeviceVitalsRepository)
final class DeviceVitalsRepositoryImpl extends Repository
    implements DeviceVitalsRepository {
  final PlatformDataSource _platformDataSource;
  final RemoteDataSource _remoteDataSource;
  final CacheManager _cacheManager;
  final TimeProvider _timeProvider;
  final DeviceInfo _deviceInfo;

  DeviceVitalsRepositoryImpl(
    this._platformDataSource,
    this._remoteDataSource,
    this._timeProvider,
    this._deviceInfo,
    this._cacheManager,
  );

  @override
  Future<Result<ThermalStateEntity>> getThermalState() async {
    return asyncGuard(() async {
      final response = await _platformDataSource.getThermalStatus();

      return ThermalStateMapper.toEntity(response);
    });
  }

  @override
  Future<Result<BatteryLevelEntity>> getBatteryLevel() async {
    return asyncGuard(() async {
      final response = await _platformDataSource.getBatteryLevel();

      return BatteryLevelMapper.toEntity(response);
    });
  }

  @override
  Future<Result<MemoryUsageEntity>> getMemoryUsage() async {
    return asyncGuard(() async {
      final response = await _platformDataSource.getMemoryUsage();

      return MemoryUsageMapper.toEntity(response);
    });
  }

  @override
  Future<Result<void>> logDeviceVitals({
    required DeviceVitalsRequestEntity request,
  }) async {
    final String deviceId;
    try {
      deviceId = await _deviceInfo.getUniqueId();
    } catch (e) {
      return Failure.mapExceptionToFailure(e);
    }
    String timestamp = _timeProvider.nowUtc().toIso8601String();

    final body = DeviceVitalsRequestMapper.toModel(
      entity: request,
      timestamp: timestamp,
      deviceId: deviceId,
    );

    try {
      await _remoteDataSource.logDeviceVitals(body: body);
    } on DioException {
      await _cacheManager.saveLog(
        CachedDeviceVitalsRequestModel.fromModel(body),
      );
      return Failure(
        'Failed to log device vitals due to connection error, will try again later',
      );
    } catch (e) {
      return Failure('Failed to log device vitals');
    }

    return const Success(null);
  }

  @override
  Future<Result<List<DeviceVitalsEntity>>> getDeviceVitalsHistory({
    int limit = 100,
  }) async {
    return asyncGuard(() async {
      final deviceId = await _deviceInfo.getUniqueId();
      final response = await _remoteDataSource.getDeviceVitalsHistory(
        deviceId: deviceId,
        limit: limit,
      );

      return DeviceVitalsMapper.toEntityList(response.data);
    });
  }

  @override
  Future<Result<DeviceVitalsAnalyticsEntity>> getDeviceVitalsAnalytics({
    required DateRange dateRange,
  }) async {
    return asyncGuard(() async {
      final deviceId = await _deviceInfo.getUniqueId();
      final response = await _remoteDataSource.getDeviceVitalsAnalytics(
        deviceId: deviceId,
        dateRange: dateRange.value,
      );

      return DeviceVitalsAnalyticsMapper.toEntity(response);
    });
  }
}
