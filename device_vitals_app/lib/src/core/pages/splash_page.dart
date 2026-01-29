import 'package:device_vitals_app/src/core/routes/routes.dart';
import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!mounted) return;
        context.go(AppRoutes.dashboard);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.surfaceBackground,
        child: Center(
          child: SizedBox(
            child: Image.asset(
              'assets/images/device_vitals_splash.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
