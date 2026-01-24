import 'package:device_vitals_app/src/core/routes/router.dart';
import 'package:device_vitals_app/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
