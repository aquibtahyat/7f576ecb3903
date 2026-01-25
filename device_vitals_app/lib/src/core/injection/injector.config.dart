// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/device_vitals/data/data_sources/platform_data_source.dart'
    as _i987;
import '../../features/device_vitals/data/repositories/device_vitals_repository_impl.dart'
    as _i757;
import '../../features/device_vitals/domain/repositories/device_vitals_repository.dart'
    as _i687;
import '../../features/device_vitals/domain/use_cases/get_battery_level.dart'
    as _i125;
import '../../features/device_vitals/domain/use_cases/get_memory_usage.dart'
    as _i186;
import '../../features/device_vitals/domain/use_cases/get_thermal_state.dart'
    as _i643;
import '../../features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart'
    as _i596;
import '../../features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart'
    as _i101;
import '../../features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart'
    as _i966;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i987.PlatformDataSource>(
      () => _i987.PlatformDataSource(),
    );
    gh.lazySingleton<_i687.DeviceVitalsRepository>(
      () => _i757.DeviceVitalsRepositoryImpl(gh<_i987.PlatformDataSource>()),
    );
    gh.factory<_i125.GetBatteryLevel>(
      () => _i125.GetBatteryLevel(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i186.GetMemoryUsage>(
      () => _i186.GetMemoryUsage(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i643.GetThermalState>(
      () => _i643.GetThermalState(gh<_i687.DeviceVitalsRepository>()),
    );
    gh.factory<_i596.GetBatteryLevelCubit>(
      () => _i596.GetBatteryLevelCubit(useCase: gh<_i125.GetBatteryLevel>()),
    );
    gh.factory<_i966.GetThermalStateCubit>(
      () => _i966.GetThermalStateCubit(useCase: gh<_i643.GetThermalState>()),
    );
    gh.factory<_i101.GetMemoryUsageCubit>(
      () => _i101.GetMemoryUsageCubit(useCase: gh<_i186.GetMemoryUsage>()),
    );
    return this;
  }
}
