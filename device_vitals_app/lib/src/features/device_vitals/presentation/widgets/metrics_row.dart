import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/metrics_stats_entity.dart';
import 'package:flutter/material.dart';

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key, required this.metrics});

  final MetricsStatsEntity metrics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GridView.extent(
      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2 - 12,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _tile(theme, 'Min', metrics.min.toStringAsFixed(1)),
        _tile(theme, 'Max', metrics.max.toStringAsFixed(1)),
        _tile(theme, 'Average', metrics.average.toStringAsFixed(1)),
        _tile(theme, 'Rolling avg', metrics.rollingAverage.toStringAsFixed(1)),
      ],
    );
  }

  Widget _tile(TextTheme theme, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            style: theme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            style: theme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      ),
    );
  }
}
