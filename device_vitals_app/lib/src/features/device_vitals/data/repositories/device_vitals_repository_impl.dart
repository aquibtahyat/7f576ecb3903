import 'package:device_vitals_app/src/core/base/repository.dart';
import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/utils/services/device_info.dart';
import 'package:device_vitals_app/src/core/utils/services/time_provider.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/platform/platform_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/remote/remote_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/battery_level_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/memory_usage_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/thermal_state_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/params/device_vitals_request_params.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeviceVitalsRepository)
final class DeviceVitalsRepositoryImpl extends Repository
    implements DeviceVitalsRepository {
  final PlatformDataSource _platformDataSource;
  final RemoteDataSource _remoteDataSource;
  final TimeProvider _timeProvider;
  final DeviceInfo _deviceInfo;

  DeviceVitalsRepositoryImpl(
    this._platformDataSource,
    this._remoteDataSource,
    this._timeProvider,
    this._deviceInfo,
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
    required DeviceVitalsRequestParams request,
  }) async {
    final deviceId = await _deviceInfo.getDeviceId();

    if (deviceId == null || deviceId.isEmpty) {
      return const Failure(
        'Device ID not found on this device. Unable to load history.',
      );
    }

    return asyncGuard(() async {
      final body = DeviceVitalsRequestModel(
        timestamp: _timeProvider.nowUtc().toIso8601String(),
        deviceId: deviceId,
        thermalValue: request.thermalValue,
        batteryLevel: request.batteryLevel,
        memoryUsage: request.memoryUsage,
      );

      await _remoteDataSource.logDeviceVitals(body: body);
    });
  }
}
