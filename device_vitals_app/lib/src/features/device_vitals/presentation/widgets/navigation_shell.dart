import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.statefulNavigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.statefulNavigationShell.currentIndex,
        onTap: (index) {
          widget.statefulNavigationShell.goBranch(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_customize),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}
