import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.strokeWidth = 4, this.size = 24});

  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
