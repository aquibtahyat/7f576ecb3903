import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDeviceVitalsHistory
    implements UseCase<Result<List<DeviceVitalsEntity>>, NoParams> {
  final DeviceVitalsRepository _repository;

  GetDeviceVitalsHistory(this._repository);

  @override
  Future<Result<List<DeviceVitalsEntity>>> call(NoParams params) async {
    return await _repository.getDeviceVitalsHistory();
  }
}
