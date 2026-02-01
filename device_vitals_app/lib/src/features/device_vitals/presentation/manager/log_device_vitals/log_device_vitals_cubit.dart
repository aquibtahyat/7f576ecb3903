import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/log_device_vitals.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/log_device_vitals/log_device_vitals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogDeviceVitalsCubit extends Cubit<LogDeviceVitalsState> {
  final LogDeviceVitals useCase;

  LogDeviceVitalsCubit(this.useCase) : super(const LogDeviceVitalsInitial());

  Future<void> logDeviceVitals(
    DeviceVitalsRequestEntity request, {
    bool isAutoLog = false,
  }) async {
    emit(const LogDeviceVitalsLoading());

    final result = await useCase(request);

    result.when(
      success: (_) => emit(LogDeviceVitalsSuccess(isAutoLog: isAutoLog)),
      failure: (message) => emit(LogDeviceVitalsFailure(message)),
    );
  }
}
