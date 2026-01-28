import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/vitals_metric_color.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VitalsCard extends StatelessWidget {
  const VitalsCard({
    super.key,
    required this.metricType,
    required this.title,
    required this.icon,
    this.value,
    this.label,
    required this.maxValue,
    this.onFailRefresh,
  }) : _isLoading = false,
       _isFailed = false;

  const VitalsCard.loading({super.key, required this.metricType})
    : title = null,
      icon = null,
      value = null,
      label = null,
      onFailRefresh = null,
      maxValue = 0,
      _isLoading = true,
      _isFailed = false;

  const VitalsCard.failed({
    super.key,
    required this.metricType,
    required this.title,
    required this.icon,
    required this.onFailRefresh,
  }) : value = null,
       label = 'Not Available',
       maxValue = 0,
       _isLoading = false,
       _isFailed = true;

  final VitalMetricType metricType;
  final String? title;
  final IconData? icon;
  final num? value;
  final String? label;
  final int maxValue;
  final VoidCallback? onFailRefresh;
  final bool _isLoading;
  final bool _isFailed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderMedium, width: 1),
      ),
      child: _isLoading
          ? const Center(child: LoadingWidget())
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: _getColor().withValues(alpha: 0.1),
              child: Icon(icon, color: _getColor()),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title!, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(
                  label ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: _getColor()),
                ),
              ],
            ),
            const Spacer(),
            if (!_isFailed)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value != null ? '$value' : '-',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: _getColor()),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '/$maxValue',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            else
              InkWell(
                onTap: _isLoading ? null : onFailRefresh,
                child: const Icon(Icons.refresh, color: AppColors.grey),
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (!_isFailed && value != null && maxValue > 0)
          LayoutBuilder(
            builder: (context, constraints) => LinearPercentIndicator(
              width: constraints.maxWidth,
              lineHeight: 8,
              percent: value! / maxValue,
              backgroundColor: AppColors.lightGrey,
              progressColor: _getColor(),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) => Container(
              height: 8,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: _isFailed ? AppColors.errorLight : AppColors.lightGrey,
              ),
            ),
          ),
      ],
    );
  }

  Color _getColor() {
    return switch (metricType) {
      VitalMetricType.thermal => VitalMetricColor.getThermalColor(
        value,
        isFailed: _isFailed,
      ),
      VitalMetricType.battery => VitalMetricColor.getBatteryColor(
        value,
        isFailed: _isFailed,
      ),
      VitalMetricType.memory => VitalMetricColor.getMemoryColor(
        value,
        isFailed: _isFailed,
      ),
    };
  }
}
