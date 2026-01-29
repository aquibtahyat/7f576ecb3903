import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/formatters/time_formatter.dart';
import 'package:device_vitals_app/src/core/utils/vitals_metric_color.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/thermal_status_enum.dart';
import 'package:flutter/material.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({super.key, required this.deviceVitals});

  final DeviceVitalsEntity deviceVitals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderMedium, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.timer_sharp, color: AppColors.grey, size: 16),
                const SizedBox(width: 8),
                Text(
                  TimeFormatter.formatDateTime(deviceVitals.timestamp),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ThermalStatus.getLabelFromValue(
                        deviceVitals.thermalValue,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: VitalMetricColor.getThermalColor(
                          deviceVitals.thermalValue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thermostat_outlined,
                          color: AppColors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Thermal',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${deviceVitals.batteryLevel}%',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: VitalMetricColor.getBatteryColor(
                          deviceVitals.batteryLevel,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.battery_charging_full,
                          color: AppColors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Battery',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      '${deviceVitals.memoryUsage}%',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: VitalMetricColor.getMemoryColor(
                          deviceVitals.memoryUsage,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.memory_sharp,
                          color: AppColors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Memory',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
