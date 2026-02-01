import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppSnackBarTheme {
  AppSnackBarTheme._();

  static final SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primaryLight,
    contentTextStyle: AppTextTheme.textTheme.labelLarge,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
    elevation: 6,
    insetPadding: const EdgeInsets.all(16),
  );
}
