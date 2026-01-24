import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppFABTheme {
  AppFABTheme._();

  static final FloatingActionButtonThemeData lightFABTheme =
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        enableFeedback: true,
      );
}
