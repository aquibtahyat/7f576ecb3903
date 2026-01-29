import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/metrics_grid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MemoryUsageAnalytics extends StatelessWidget {
  const MemoryUsageAnalytics({super.key, required this.analytics});

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
                Icon(Icons.memory_sharp, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Memory Usage',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 16),
            MetricsGrid(metrics: analytics.metrics.memory),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 300, maxHeight: 500),
              child: SizedBox(
                height: 400,
                child: SfCartesianChart(
                  backgroundColor: AppColors.white,
                  plotAreaBackgroundColor: AppColors.screenBackground,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('HH:mma\nMMM dd'),
                    intervalType: DateTimeIntervalType.auto,
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                    axisLine: AxisLine(color: AppColors.borderMedium, width: 1),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Memory Usage'),
                    minimum: 0,
                    maximum: 100,
                    interval: 10,
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                    axisLine: AxisLine(color: AppColors.borderMedium, width: 1),
                  ),
                  series: [
                    SplineSeries<DeviceVitalsEntity, DateTime>(
                      dataSource: analytics.series,
                      xValueMapper: (DeviceVitalsEntity series, _) =>
                          series.timestamp,
                      yValueMapper: (DeviceVitalsEntity series, _) =>
                          series.memoryUsage,
                      color: AppColors.primary,
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
