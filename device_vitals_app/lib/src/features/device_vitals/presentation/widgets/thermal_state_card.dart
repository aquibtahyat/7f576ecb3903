import 'package:device_vitals_app/src/core/utils/vitals_metric_color.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/thermal_status_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/vitals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThermalStateCard extends StatelessWidget {
  const ThermalStateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetThermalStateCubit, GetThermalStateState>(
      builder: (context, state) {
        if (state is GetThermalStateLoading) {
          return VitalsCard.loading(metricType: VitalMetricType.thermal);
        } else if (state is GetThermalStateSuccess) {
          return VitalsCard(
            metricType: VitalMetricType.thermal,
            title: 'Thermal State',
            icon: Icons.thermostat_outlined,
            label: ThermalStatus.getLabelFromValue(state.thermalState.value),
            value: state.thermalState.value,
            maxValue: 3,
            onFailRefresh: () {
              context.read<GetThermalStateCubit>().getThermalState();
            },
          );
        } else {
          return VitalsCard.failed(
            metricType: VitalMetricType.thermal,
            title: 'Thermal State',
            icon: Icons.thermostat_outlined,
            onFailRefresh: () {
              context.read<GetThermalStateCubit>().getThermalState();
            },
          );
        }
      },
    );
  }
}
