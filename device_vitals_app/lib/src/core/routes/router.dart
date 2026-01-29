import 'package:device_vitals_app/src/core/pages/splash_page.dart';
import 'package:device_vitals_app/src/core/routes/parts/shell_routes.dart';
import 'package:device_vitals_app/src/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        pageBuilder: (context, state) => MaterialPage(child: SplashPage()),
      ),
      shellRoutes(),
    ],
  );
}
