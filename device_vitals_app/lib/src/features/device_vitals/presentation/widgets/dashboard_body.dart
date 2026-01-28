import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/battery_level_card.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/log_vitals_button.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/memory_usage_card.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/thermal_state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _getDashboardData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _getDashboardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetThermalStateCubit, GetThermalStateState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is GetThermalStateFailure) {
              if (state.isLoadAll) {
                _showCombinedFailures(context);
              } else {
                context.showSnackBar(state.message);
              }
            }
          },
        ),
        BlocListener<GetBatteryLevelCubit, GetBatteryLevelState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is GetBatteryLevelFailure) {
              if (state.isLoadAll) {
                _showCombinedFailures(context);
              } else {
                context.showSnackBar(state.message);
              }
            }
          },
        ),
        BlocListener<GetMemoryUsageCubit, GetMemoryUsageState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state is GetMemoryUsageFailure) {
              if (state.isLoadAll) {
                _showCombinedFailures(context);
              } else {
                context.showSnackBar(state.message);
              }
            }
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: _getDashboardData,
        child: Scaffold(
          backgroundColor: AppColors.screenBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ThermalStateCard(),
                    const SizedBox(height: 16),
                    BatteryLevelCard(),
                    const SizedBox(height: 16),
                    MemoryUsageCard(),
                    const SizedBox(height: 24),
                    LogVitalsButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDashboardData() async {
    await Future.wait([
      context.read<GetThermalStateCubit>().getThermalState(isLoadAll: true),
      context.read<GetBatteryLevelCubit>().getBatteryLevel(isLoadAll: true),
      context.read<GetMemoryUsageCubit>().getMemoryUsage(isLoadAll: true),
    ]);
  }

  void _showCombinedFailures(BuildContext context) {
    final messages = <String>[];

    final t = context.read<GetThermalStateCubit>().state;
    if (t is GetThermalStateFailure) {
      messages.add(t.message);
    }

    final b = context.read<GetBatteryLevelCubit>().state;
    if (b is GetBatteryLevelFailure) {
      messages.add(b.message);
    }

    final m = context.read<GetMemoryUsageCubit>().state;
    if (m is GetMemoryUsageFailure) {
      messages.add(m.message);
    }

    if (messages.isNotEmpty) {
      context.showSnackBar(messages.join('\n\n'));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
