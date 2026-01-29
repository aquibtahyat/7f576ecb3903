// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/device_vitals/data/data_sources/platform/platform_data_source.dart'
    as _i1062;
import '../../features/device_vitals/data/data_sources/remote/remote_data_source.dart'
    as _i147;
import '../../features/device_vitals/data/repositories/device_vitals_repository_impl.dart'
    as _i757;
import '../../features/device_vitals/domain/repositories/device_vitals_repository.dart'
    as _i687;
import '../../features/device_vitals/domain/use_cases/get_battery_level.dart'
    as _i125;
import '../../features/device_vitals/domain/use_cases/get_device_vitals_analytics.dart'
    as _i273;
import '../../features/device_vitals/domain/use_cases/get_device_vitals_history.dart'
    as _i710;
import '../../features/device_vitals/domain/use_cases/get_memory_usage.dart'
    as _i186;
import '../../features/device_vitals/domain/use_cases/get_thermal_state.dart'
    as _i643;
import '../../features/device_vitals/domain/use_cases/log_device_vitals.dart'
    as _i6;
import '../../features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_cubit.dart'
    as _i901;
import '../../features/device_vitals/presentation/manager/get_analytics/get_analytics_cubit.dart'
    as _i963;
import '../../features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart'
    as _i596;
import '../../features/device_vitals/presentation/manager/get_history/get_history_cubit.dart'
    as _i312;
import '../../features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart'
    as _i101;
import '../../features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart'
    as _i966;
import '../../features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_cubit.dart'
    as _i934;
import '../network/network_module.dart' as _i200;
import '../services/cache/cache_manager.dart' as _i45;
import '../services/cache/cache_manager_impl.dart' as _i196;
import '../services/device/device_info.dart' as _i288;
import '../services/time/time_service.dart' as _i483;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i1062.PlatformDataSource>(
      () => _i1062.PlatformDataSource(),
    );
    gh.lazySingleton<_i45.CacheManager>(() => _i196.CacheManagerImpl());
    gh.singleton<_i361.Dio>(
      () => networkModule.getDio(),
      instanceName: 'DIOCLIENT',
    );
    gh.lazySingleton<_i483.TimeProvider>(() => _i483.TimeProviderImpl());
    gh.lazySingleton<_i288.DeviceInfo>(
      () => _i288.DeviceInfoImpl(gh<_i45.CacheManager>()),
    );
    gh.lazySingleton<_i147.RemoteDataSource>(
      () => _i147.RemoteDataSource(gh<_i361.Dio>(instanceName: 'DIOCLIENT')),
    );
    gh.lazySingleton<_i687.DeviceVitalsRepository>(
      () => _i757.DeviceVitalsRepositoryImpl(
        gh<_i1062.PlatformDataSource>(),
        gh<_i147.RemoteDataSource>(),
        gh<_i483.TimeProvider>(),
        gh<_i288.DeviceInfo>(),
        gh<_i45.CacheManager>(),
      ),
    );
    gh.factory<_i125.GetBatteryLevel>(
      () => _i125.GetBatteryLevel(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i273.GetDeviceVitalsAnalytics>(
      () => _i273.GetDeviceVitalsAnalytics(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i710.GetDeviceVitalsHistory>(
      () => _i710.GetDeviceVitalsHistory(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i186.GetMemoryUsage>(
      () => _i186.GetMemoryUsage(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i643.GetThermalState>(
      () => _i643.GetThermalState(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i6.LogDeviceVitals>(
      () => _i6.LogDeviceVitals(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i596.GetBatteryLevelCubit>(
      () => _i596.GetBatteryLevelCubit(useCase: gh<_i125.GetBatteryLevel>()),
    );
    gh.factory<_i312.GetHistoryCubit>(
      () => _i312.GetHistoryCubit(useCase: gh<_i710.GetDeviceVitalsHistory>()),
    );
    gh.factory<_i966.GetThermalStateCubit>(
      () => _i966.GetThermalStateCubit(useCase: gh<_i643.GetThermalState>()),
    );
    gh.factory<_i934.LogDeviceVitalsCubit>(
      () => _i934.LogDeviceVitalsCubit(gh<_i6.LogDeviceVitals>()),
    );
    gh.factory<_i901.AutoLogTimerCubit>(() => _i901.AutoLogTimerCubit());
    gh.factory<_i101.GetMemoryUsageCubit>(
      () => _i101.GetMemoryUsageCubit(useCase: gh<_i186.GetMemoryUsage>()),
    );
    gh.factory<_i963.GetAnalyticsCubit>(
      () => _i963.GetAnalyticsCubit(
        useCase: gh<_i273.GetDeviceVitalsAnalytics>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
