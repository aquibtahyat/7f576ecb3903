import 'package:device_vitals_app/src/core/injection/injector.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/dashboard_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector.get<GetThermalStateCubit>(),
        ),
        BlocProvider(
          create: (context) => injector.get<GetBatteryLevelCubit>(),
        ),
        BlocProvider(
          create: (context) => injector.get<GetMemoryUsageCubit>(),
        ),
      ],
      child: const DashboardBody(),
    );
  }
}
