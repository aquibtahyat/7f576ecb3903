import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/auto_log_row_widget.dart';
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
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _getDashboardData();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;

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
        BlocListener<LogDeviceVitalsCubit, LogDeviceVitalsState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            final prefState = context.read<AutoLogPreferenceCubit>().state;
            final timerCubit = context.read<AutoLogTimerCubit>();

            if (state is LogDeviceVitalsFailure) {
              context.showSnackBar(state.message);

              if (prefState is AutoLogPreferenceSuccess &&
                  prefState.isEnabled) {
                timerCubit.startTimer();
              }
            } else if (state is LogDeviceVitalsSuccess) {
              context.showSnackBar('Status logged successfully');
              if (state.isAutoLog) {
                timerCubit.startTimer();
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Vitals'),
          elevation: 1,
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _getDashboardData,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const ThermalStateCard(),
                    const SizedBox(height: 16),
                    const BatteryLevelCard(),
                    const SizedBox(height: 16),
                    const MemoryUsageCard(),
                    const SizedBox(height: 16),
                    LogVitalsButton(onLogPressed: _onTapLogVitals),
                    const SizedBox(height: 16),
                    AutoLogRowWidget(
                      onTapAutoLog: () {
                        _getDashboardData().then((_) {
                          if (!mounted) return;
                          _onTapLogVitals(isAutoLog: true);
                        });
                      },
                    ),
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

    final tState = context.read<GetThermalStateCubit>().state;
    if (tState is GetThermalStateFailure) {
      messages.add(tState.message);
    }

    final bState = context.read<GetBatteryLevelCubit>().state;
    if (bState is GetBatteryLevelFailure) {
      messages.add(bState.message);
    }

    final mState = context.read<GetMemoryUsageCubit>().state;
    if (mState is GetMemoryUsageFailure) {
      messages.add(mState.message);
    }

    if (messages.isNotEmpty) {
      context.showSnackBar(messages.join('\n\n'));
    }
  }

  void _onTapLogVitals({bool isAutoLog = false}) {
    final tState = context.read<GetThermalStateCubit>().state;
    final bState = context.read<GetBatteryLevelCubit>().state;
    final mState = context.read<GetMemoryUsageCubit>().state;

    final thermal = tState is GetThermalStateSuccess
        ? tState.thermalState.value
        : null;
    final battery = bState is GetBatteryLevelSuccess
        ? bState.batteryLevel.batteryLevel
        : null;
    final memory = mState is GetMemoryUsageSuccess
        ? mState.memoryUsage.memoryUsage
        : null;

    final canLog = thermal != null && battery != null && memory != null;

    if (!canLog) {
      context.showSnackBar('Vitals aren’t available to log at the moment');
      return;
    }

    context.read<LogDeviceVitalsCubit>().logDeviceVitals(
      DeviceVitalsRequestEntity(
        thermalValue: thermal,
        batteryLevel: battery,
        memoryUsage: memory,
      ),
      isAutoLog: isAutoLog,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
