import 'package:device_vitals_app/src/core/injection/injector.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => injector.get<GetThermalStateCubit>()),
        BlocProvider(create: (context) => injector.get<GetBatteryLevelCubit>()),
        BlocProvider(create: (context) => injector.get<GetMemoryUsageCubit>()),
        BlocProvider(create: (context) => injector.get<LogDeviceVitalsCubit>()),
        BlocProvider(
          create: (context) => injector.get<AutoLogPreferenceCubit>(),
        ),
        BlocProvider(create: (context) => injector.get<AutoLogTimerCubit>()),
      ],
      child: const DashboardBody(),
    );
  }
}
