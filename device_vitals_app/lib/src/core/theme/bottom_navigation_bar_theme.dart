import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBarTheme {
  AppBottomNavigationBarTheme._();

  static final BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.primary,
        elevation: 0,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withValues(alpha: 0.7),
        selectedIconTheme: const IconThemeData(
          color: AppColors.white,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.white.withValues(alpha: 0.65),
          size: 24,
        ),
        selectedLabelStyle: AppTextTheme.textTheme.labelSmall?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextTheme.textTheme.labelSmall?.copyWith(
          color: AppColors.white.withValues(alpha: 0.65),
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
      );
}
