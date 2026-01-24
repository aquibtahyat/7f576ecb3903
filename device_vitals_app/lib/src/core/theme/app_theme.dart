import 'package:device_vitals_app/src/core/theme/app_bar_theme.dart';
import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/theme/app_snackbar_theme.dart';
import 'package:device_vitals_app/src/core/theme/elevated_button_theme.dart';
import 'package:device_vitals_app/src/core/theme/floating_action_button_theme.dart';
import 'package:device_vitals_app/src/core/theme/input_decoration_theme.dart';
import 'package:device_vitals_app/src/core/theme/text_button_theme.dart';
import 'package:device_vitals_app/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.screenBackground,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    textButtonTheme: AppTextButtonTheme.lightTextButtonTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: AppFABTheme.lightFABTheme,
    snackBarTheme: AppSnackBarTheme.lightSnackBarTheme,
  );
}
