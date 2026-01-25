import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/vitals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  void initState() {
    super.initState();
    _getDashboardData();
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
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Device Vitals')),
        backgroundColor: AppColors.screenBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                const SizedBox(height: 16),
                BlocBuilder<GetThermalStateCubit, GetThermalStateState>(
                  builder: (context, state) {
                    if (state is GetThermalStateLoading) {
                      return VitalsCard.loading();
                    } else if (state is GetThermalStateSuccess) {
                      return VitalsCard(
                        title: 'Thermal State',
                        icon: Icons.thermostat_outlined,
                        label: state.thermalState.label,
                        value: state.thermalState.value,
                        isColorReverse: true,
                        maxValue: 3,
                        onRefresh: () {
                          context
                              .read<GetThermalStateCubit>()
                              .getThermalState();
                        },
                      );
                    } else {
                      return VitalsCard.failed(
                        title: 'Thermal State',
                        icon: Icons.thermostat_outlined,
                        onRefresh: () {
                          context
                              .read<GetThermalStateCubit>()
                              .getThermalState();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<GetBatteryLevelCubit, GetBatteryLevelState>(
                  builder: (context, state) {
                    if (state is GetBatteryLevelLoading) {
                      return VitalsCard.loading();
                    } else if (state is GetBatteryLevelSuccess) {
                      return VitalsCard(
                        title: 'Battery Level',
                        icon: Icons.battery_charging_full,
                        label: '${state.batteryLevel.batteryLevel ?? 0}%',
                        value: state.batteryLevel.batteryLevel,
                        maxValue: 100,
                        onRefresh: () {
                          context
                              .read<GetBatteryLevelCubit>()
                              .getBatteryLevel();
                        },
                      );
                    } else {
                      return VitalsCard.failed(
                        title: 'Battery Level',
                        icon: Icons.battery_charging_full,
                        onRefresh: () {
                          context
                              .read<GetBatteryLevelCubit>()
                              .getBatteryLevel();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<GetMemoryUsageCubit, GetMemoryUsageState>(
                  builder: (context, state) {
                    if (state is GetMemoryUsageLoading) {
                      return VitalsCard.loading();
                    } else if (state is GetMemoryUsageSuccess) {
                      return VitalsCard(
                        title: 'Memory Usage',
                        icon: Icons.memory_sharp,
                        label:
                            '${(state.memoryUsage.memoryUsage ?? 0).round()}%',
                        value: state.memoryUsage.memoryUsage,
                        maxValue: 100,
                        isColorReverse: true,
                        onRefresh: () {
                          context.read<GetMemoryUsageCubit>().getMemoryUsage();
                        },
                      );
                    } else {
                      return VitalsCard.failed(
                        title: 'Memory Usage',
                        icon: Icons.storage,
                        onRefresh: () {
                          context.read<GetMemoryUsageCubit>().getMemoryUsage();
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getDashboardData() async {
    final thermalCubit = context.read<GetThermalStateCubit>();
    final batteryCubit = context.read<GetBatteryLevelCubit>();
    final memoryCubit = context.read<GetMemoryUsageCubit>();

    await Future.wait([
      thermalCubit.getThermalState(isLoadAll: true),
      batteryCubit.getBatteryLevel(isLoadAll: true),
      memoryCubit.getMemoryUsage(isLoadAll: true),
    ]);
  }

  void _showCombinedFailures(BuildContext context) {
    final messages = <String>[];

    final t = context.read<GetThermalStateCubit>().state;
    if (t is GetThermalStateFailure) {
      messages.add('Thermal: ${t.message}');
    }

    final b = context.read<GetBatteryLevelCubit>().state;
    if (b is GetBatteryLevelFailure) {
      messages.add('Battery: ${b.message}');
    }

    final m = context.read<GetMemoryUsageCubit>().state;
    if (m is GetMemoryUsageFailure) {
      messages.add('Memory: ${m.message}');
    }

    if (messages.isNotEmpty) {
      context.showSnackBar(
        messages.join('\n\n'),
        duration: Duration(seconds: messages.length > 1 ? 6 : 4),
      );
    }
  }
}
