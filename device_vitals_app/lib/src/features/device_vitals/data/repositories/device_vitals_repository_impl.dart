import 'package:device_vitals_app/src/core/base/repository.dart';
import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/platform_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/battery_level_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/memory_usage_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/mappers/thermal_state_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeviceVitalsRepository)
final class DeviceVitalsRepositoryImpl extends Repository
    implements DeviceVitalsRepository {
  final PlatformDataSource _platformDataSource;

  DeviceVitalsRepositoryImpl(this._platformDataSource);

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
}
