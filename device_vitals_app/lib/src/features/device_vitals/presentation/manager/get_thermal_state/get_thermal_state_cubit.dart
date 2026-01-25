import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_thermal_state.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_thermal_state/get_thermal_state_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetThermalStateCubit extends Cubit<GetThermalStateState> {
  GetThermalStateCubit({required this.useCase})
    : super(GetThermalStateInitial());

  final GetThermalState useCase;

  Future<void> getThermalState({bool isLoadAll = false}) async {
    emit(const GetThermalStateLoading());

    final result = await useCase(NoParams());

    result.when(
      success: (data) => emit(GetThermalStateSuccess(data)),
      failure: (message) =>
          emit(GetThermalStateFailure(message, isLoadAll: isLoadAll)),
    );
  }
}
