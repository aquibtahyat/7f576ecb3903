import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/metrics_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ThermalStateAnalytics extends StatelessWidget {
  const ThermalStateAnalytics({super.key, required this.analytics});

  final DeviceVitalsAnalyticsEntity analytics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderMedium, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.thermostat_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Thermal State',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            MetricsGrid(metrics: analytics.metrics.thermal),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 300, maxHeight: 500),
              child: SizedBox(
                child: SfCartesianChart(
                  backgroundColor: AppColors.white,
                  plotAreaBackgroundColor: AppColors.screenBackground,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('hh:mm a\nMMM dd'),
                    maximumLabels: 8,
                    desiredIntervals: 7,
                    labelRotation: -45,
                    intervalType: DateTimeIntervalType.auto,
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                    axisLine: AxisLine(color: AppColors.borderMedium, width: 1),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Thermal Value'),
                    minimum: 0,
                    maximum: 3,
                    interval: 1,
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                    axisLine: AxisLine(color: AppColors.borderMedium, width: 1),
                  ),
                  series: [
                    StepAreaSeries<DeviceVitalsEntity, DateTime>(
                      dataSource: analytics.series,
                      xValueMapper: (DeviceVitalsEntity series, _) =>
                          series.timestamp,
                      yValueMapper: (DeviceVitalsEntity series, _) =>
                          series.thermalValue,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withAlpha(80),
                          AppColors.primary.withAlpha(20),
                        ],
                      ),
                      borderColor: AppColors.primary,
                      borderWidth: 2,
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    format: 'point.x : point.y',
                    header: '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
