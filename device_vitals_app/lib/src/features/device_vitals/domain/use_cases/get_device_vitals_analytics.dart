import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/enums/date_range_enum.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDeviceVitalsAnalytics
    implements UseCase<Result<DeviceVitalsAnalyticsEntity>, DateRange> {
  final DeviceVitalsRepository _repository;

  GetDeviceVitalsAnalytics(this._repository);

  @override
  Future<Result<DeviceVitalsAnalyticsEntity>> call(DateRange params) async {
    return await _repository.getDeviceVitalsAnalytics(dateRange: params);
  }
}
