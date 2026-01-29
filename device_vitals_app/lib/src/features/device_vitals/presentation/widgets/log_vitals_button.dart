import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogVitalsButton extends StatelessWidget {
  const LogVitalsButton({super.key, required this.onLogPressed});

  final VoidCallback onLogPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:       BlocConsumer<LogDeviceVitalsCubit, LogDeviceVitalsState>(
        listenWhen: (previous, current) =>
            current is LogDeviceVitalsFailure ||
            current is LogDeviceVitalsSuccess,
        listener: (context, state) {
          if (state is LogDeviceVitalsFailure) {
            context.showSnackBar(state.message);
          }
          if (state is LogDeviceVitalsSuccess) {
            context.showSnackBar('Status logged successfully');
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () =>
                state is LogDeviceVitalsLoading ? null : onLogPressed.call(),
            child: state is LogDeviceVitalsLoading
                ? const LoadingWidget()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload),
                      const SizedBox(width: 8),
                      Text(
                        'Log Status',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
