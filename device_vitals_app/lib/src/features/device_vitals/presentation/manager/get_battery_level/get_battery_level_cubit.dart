import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_battery_level.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_battery_level/get_battery_level_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBatteryLevelCubit extends Cubit<GetBatteryLevelState> {
  GetBatteryLevelCubit({required this.useCase})
    : super(const GetBatteryLevelInitial());

  final GetBatteryLevel useCase;

  Future<void> getBatteryLevel({bool isLoadAll = false}) async {
    emit(const GetBatteryLevelLoading());

    final result = await useCase(NoParams());

    result.when(
      success: (data) => emit(GetBatteryLevelSuccess(data)),
      failure: (message) =>
          emit(GetBatteryLevelFailure(message, isLoadAll: isLoadAll)),
    );
  }
}
