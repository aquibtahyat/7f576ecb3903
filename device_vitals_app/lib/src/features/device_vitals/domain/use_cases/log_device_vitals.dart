import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/params/device_vitals_request_params.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogDeviceVitals
    implements UseCase<Result<void>, DeviceVitalsRequestParams> {
  final DeviceVitalsRepository _repository;

  LogDeviceVitals(this._repository);

  @override
  Future<Result<void>> call(DeviceVitalsRequestParams request) async {
    return await _repository.logDeviceVitals(request: request);
  }
}
