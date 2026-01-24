import 'package:device_vitals_app/src/core/routes/routes.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.dashboard,
    debugLogDiagnostics: true, // turn off in prod if needed

    routes: [
      GoRoute(
        path: AppRoutes.dashboard,
        pageBuilder: (context, state) =>
            const MaterialPage(child: DashboardPage()),
      ),
    ],
  );
}
