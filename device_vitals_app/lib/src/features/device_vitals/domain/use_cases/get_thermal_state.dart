import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetThermalState implements UseCase<Result<ThermalStateEntity>, NoParams> {
  final DeviceVitalsRepository _repository;

  GetThermalState(this._repository);

  @override
  Future<Result<ThermalStateEntity>> call(NoParams params) async {
    return await _repository.getThermalState();
  }
}
