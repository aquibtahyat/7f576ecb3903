import 'package:device_vitals_app/src/core/utils/vitals_metric_color.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/vitals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemoryUsageCard extends StatelessWidget {
  const MemoryUsageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMemoryUsageCubit, GetMemoryUsageState>(
      builder: (context, state) {
        if (state is GetMemoryUsageLoading) {
          return VitalsCard.loading(metricType: VitalMetricType.memory);
        } else if (state is GetMemoryUsageSuccess) {
          return VitalsCard(
            metricType: VitalMetricType.memory,
            title: 'Memory Usage',
            icon: Icons.memory_sharp,
            label: '${(state.memoryUsage.memoryUsage ?? 0).round()}%',
            value: state.memoryUsage.memoryUsage,
            maxValue: 100,
            onFailRefresh: () {
              context.read<GetMemoryUsageCubit>().getMemoryUsage();
            },
          );
        } else {
          return VitalsCard.failed(
            metricType: VitalMetricType.memory,
            title: 'Memory Usage',
            icon: Icons.memory_sharp,
            onFailRefresh: () {
              context.read<GetMemoryUsageCubit>().getMemoryUsage();
            },
          );
        }
      },
    );
  }
}
