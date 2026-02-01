import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoLogSwitch extends StatefulWidget {
  const AutoLogSwitch({super.key});

  @override
  State<AutoLogSwitch> createState() => _AutoLogSwitchState();
}

class _AutoLogSwitchState extends State<AutoLogSwitch>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AutoLogPreferenceCubit>().getPreference();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!mounted) return;
    final timerCubit = context.read<AutoLogTimerCubit>();
    final preferenceCubit = context.read<AutoLogPreferenceCubit>();
    if (state == AppLifecycleState.resumed) {
      preferenceCubit.getPreference();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      timerCubit.stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AutoLogPreferenceCubit, AutoLogPreferenceState>(
      listener: (context, state) {
        final timerCubit = context.read<AutoLogTimerCubit>();

        if (state is AutoLogPreferenceFailure) {
          context.showSnackBar(state.message);
          timerCubit.stopTimer();
        } else if (state is AutoLogPreferenceSuccess) {
          if (state.isEnabled) {
            timerCubit.startTimer();
          } else {
            timerCubit.stopTimer();
          }
        }
      },
      builder: (context, state) {
        final value = state is AutoLogPreferenceSuccess && state.isEnabled;
        if (state is AutoLogPreferenceLoading) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: const LoadingWidget(size: 18, strokeWidth: 2),
          );
        }

        return Switch(
          activeThumbColor: AppColors.primary,
          activeTrackColor: AppColors.primary.withValues(alpha: 0.2),
          value: value,
          onChanged: (value) {
            context.read<AutoLogPreferenceCubit>().setPreference(value);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
