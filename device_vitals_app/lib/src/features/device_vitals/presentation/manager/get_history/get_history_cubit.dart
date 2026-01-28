import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_device_vitals_history.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_history/get_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHistoryCubit extends Cubit<GetHistoryState> {
  GetHistoryCubit({required this.useCase}) : super(const GetHistoryInitial());

  final GetDeviceVitalsHistory useCase;

  Future<void> getHistory() async {
    emit(const GetHistoryLoading());

    final result = await useCase(NoParams());

    result.when(
      success: (data) => emit(GetHistorySuccess(data)),
      failure: (message) => emit(GetHistoryFailure(message)),
    );
  }
}
