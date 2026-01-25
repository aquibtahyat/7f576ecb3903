import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBatteryLevel implements UseCase<Result<BatteryLevelEntity>, NoParams> {
  final DeviceVitalsRepository _repository;

  GetBatteryLevel(this._repository);

  @override
  Future<Result<BatteryLevelEntity>> call(NoParams params) async {
    return await _repository.getBatteryLevel();
  }
}
