import 'package:device_vitals_app/src/core/theme/app_colors.dart';
import 'package:device_vitals_app/src/core/utils/extensions/snackbar_extension.dart';
import 'package:device_vitals_app/src/core/utils/widgets/loading_widget.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_cubit.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogVitalsButton extends StatelessWidget {
  const LogVitalsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<LogDeviceVitalsCubit, LogDeviceVitalsState>(
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
            onPressed: () => state is LogDeviceVitalsLoading
                ? null
                : _onTapLogStatus(context),
            child: state is LogDeviceVitalsLoading
                ? LoadingWidget()
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

  void _onTapLogStatus(BuildContext context) {
    final tState = context.read<GetThermalStateCubit>().state;
    final bState = context.read<GetBatteryLevelCubit>().state;
    final mState = context.read<GetMemoryUsageCubit>().state;

    final thermal = tState is GetThermalStateSuccess ? tState.thermalState.value : null;
    final battery = bState is GetBatteryLevelSuccess ? bState.batteryLevel.batteryLevel : null;
    final memory = mState is GetMemoryUsageSuccess ? mState.memoryUsage.memoryUsage : null;

    final canLog = thermal != null && battery != null && memory != null;

    if (!canLog) {
      context.showSnackBar('Vitals are not available for log');
      return;
    }

    context.read<LogDeviceVitalsCubit>().logDeviceVitals(
      DeviceVitalsRequestEntity(
        thermalValue: thermal,
        batteryLevel: battery,
        memoryUsage: memory,
      ),
    );
  }
}
