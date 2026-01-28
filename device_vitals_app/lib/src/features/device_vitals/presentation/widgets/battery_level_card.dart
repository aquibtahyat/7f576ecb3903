import 'package:device_vitals_app/src/core/utils/vitals_metric_color.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/vitals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryLevelCard extends StatelessWidget {
  const BatteryLevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBatteryLevelCubit, GetBatteryLevelState>(
      builder: (context, state) {
        if (state is GetBatteryLevelLoading) {
          return VitalsCard.loading(metricType: VitalMetricType.battery);
        } else if (state is GetBatteryLevelSuccess) {
          return VitalsCard(
            metricType: VitalMetricType.battery,
            title: 'Battery Level',
            icon: Icons.battery_charging_full,
            label: '${state.batteryLevel.batteryLevel ?? 0}%',
            value: state.batteryLevel.batteryLevel,
            maxValue: 100,
            onFailRefresh: () {
              context.read<GetBatteryLevelCubit>().getBatteryLevel();
            },
          );
        } else {
          return VitalsCard.failed(
            metricType: VitalMetricType.battery,
            title: 'Battery Level',
            icon: Icons.battery_charging_full,
            onFailRefresh: () {
              context.read<GetBatteryLevelCubit>().getBatteryLevel();
            },
          );
        }
      },
    );
  }
}
