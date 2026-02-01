import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeAutoLogPreference extends UseCase<Result<bool>, bool> {
  final DeviceVitalsRepository _repository;

  ChangeAutoLogPreference(this._repository);

  @override
  Future<Result<bool>> call(bool params) async {
    return await _repository.changeAutoLogPreference(value: params);
  }
}
