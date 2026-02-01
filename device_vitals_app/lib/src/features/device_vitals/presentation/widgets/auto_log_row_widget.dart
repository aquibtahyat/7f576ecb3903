import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/widgets/auto_log_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoLogRowWidget extends StatelessWidget {
  const AutoLogRowWidget({super.key, required this.onTapAutoLog});

  final VoidCallback onTapAutoLog;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutoLogTimerCubit, AutoLogTimerState>(
      listener: (context, state) {
        if (state is AutoLogTimerTrigger) {
          onTapAutoLog();
        }
        if (state is AutoLogTimerRunning && state.showSoonWarning) {
          context.showSnackBar('Auto logging soon');
        }
        if (state is AutoLogTimerStopped &&
            state.message != null &&
            state.message!.isNotEmpty) {
          context.showSnackBar(state.message!);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderDark, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withAlpha(150),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2,
                      ),
                    ),
                    child: state is AutoLogTimerRunning
                        ? Text(
                            '${state.seconds}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.primaryLight),
                          )
                        : Text(
                            '60',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.primaryLight),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto-Logging',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Every minute while on screen',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AutoLogSwitch(),
            ],
          ),
        );
      },
    );
  }
}
