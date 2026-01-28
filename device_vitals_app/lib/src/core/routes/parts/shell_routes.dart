import 'package:device_vitals_app/src/core/routes/routes.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/pages/analytics_page.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/pages/dashboard_page.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/pages/history_page.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

StatefulShellRoute shellRoutes() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return NavigationShell(statefulNavigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            name: AppRoutes.dashboard,
            pageBuilder: (context, state) {
              return const MaterialPage(child: DashboardPage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.history,
            name: AppRoutes.history,
            pageBuilder: (context, state) {
              return const MaterialPage(child: HistoryPage());
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.analytics,
            name: AppRoutes.analytics,
            pageBuilder: (context, state) {
              return const MaterialPage(child: AnalyticsPage());
            },
          ),
        ],
      ),
    ],
  );
}
