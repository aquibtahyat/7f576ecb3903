import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_device_vitals_analytics.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/get_analytics/get_analytics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAnalyticsCubit extends Cubit<GetAnalyticsState> {
  GetAnalyticsCubit({required this.useCase})
    : super(const GetAnalyticsInitial());

  final GetDeviceVitalsAnalytics useCase;

  Future<void> getAnalytics({required DateRange dateRange}) async {
    emit(GetAnalyticsLoading(dateRange: dateRange));

    final result = await useCase(dateRange);

    result.when(
      success: (data) => emit(GetAnalyticsSuccess(
        analytics: data,
        dateRange: dateRange,
      )),
      failure: (message) => emit(GetAnalyticsFailure(
        message: message,
        dateRange: dateRange,
      )),
    );
  }
}
