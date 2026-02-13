import 'dart:ui';

import 'package:device_vitals_app/src/core/theme/app_colors.dart';

enum VitalMetricType { thermal, battery, memory }

class VitalMetricColor {
  VitalMetricColor._();

  static Color getThermalColor(num? value, {bool isFailed = false}) {
    if (isFailed) return AppColors.error;
    if (value == null) return AppColors.grey;
    final r = value.toDouble() / 3;
    if (r <= 0.5) return AppColors.success;
    if (r <= 0.85) return AppColors.warning;
    return AppColors.error;
  }

  static Color getBatteryColor(num? value, {bool isFailed = false}) {
    if (isFailed) return AppColors.error;
    if (value == null) return AppColors.grey;
    final v = value.toInt();
    if (v < 20) return AppColors.error;
    if (v < 67) return AppColors.warning;
    return AppColors.success;
  }

  static Color getMemoryColor(num? value, {bool isFailed = false}) {
    if (isFailed) return AppColors.errorDark;
    if (value == null) return AppColors.grey;
    final r = value.toDouble() / 100;
    if (r <= 0.33) return AppColors.success;
    if (r <= 0.67) return AppColors.warning;
    return AppColors.error;
  }
}
