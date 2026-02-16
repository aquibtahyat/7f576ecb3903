import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/log_device_vitals.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogDeviceVitalsCubit extends Cubit<LogDeviceVitalsState> {
  final LogDeviceVitals useCase;

  LogDeviceVitalsCubit(this.useCase) : super(const LogDeviceVitalsInitial());

  Future<void> logDeviceVitals({
    int? thermalValue,
    int? batteryLevel,
    int? memoryUsage,
    bool isAutoLog = false,
  }) async {
    emit(const LogDeviceVitalsLoading());

    if (thermalValue == null || batteryLevel == null || memoryUsage == null) {
      emit(
        LogDeviceVitalsFailure(
          'Vitals aren’t available to log at the moment',
          isAutoLog: isAutoLog,
        ),
      );
      return;
    }

    final request = DeviceVitalsRequestEntity(
      thermalValue: thermalValue,
      batteryLevel: batteryLevel,
      memoryUsage: memoryUsage,
    );

    final result = await useCase(request);

    result.when(
      success: (_) => emit(LogDeviceVitalsSuccess(isAutoLog: isAutoLog)),
      failure: (message) =>
          emit(LogDeviceVitalsFailure(message, isAutoLog: isAutoLog)),
    );
  }
}
