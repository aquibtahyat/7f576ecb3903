import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_memory_usage.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_memory_usage/get_memory_usage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMemoryUsageCubit extends Cubit<GetMemoryUsageState> {
  GetMemoryUsageCubit({required this.useCase}) : super(const GetMemoryUsageInitial());

  final GetMemoryUsage useCase;

  Future<void> getMemoryUsage({bool isLoadAll = false}) async {
    emit(const GetMemoryUsageLoading());

    final result = await useCase(NoParams());

    result.when(
      success: (data) => emit(GetMemoryUsageSuccess(data)),
      failure: (message) =>
          emit(GetMemoryUsageFailure(message, isLoadAll: isLoadAll)),
    );
  }
}
