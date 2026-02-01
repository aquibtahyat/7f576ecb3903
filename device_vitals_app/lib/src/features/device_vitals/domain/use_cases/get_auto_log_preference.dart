import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAutoLogPreference extends UseCase<Result<bool>, NoParams> {
  final DeviceVitalsRepository _repository;

  GetAutoLogPreference(this._repository);

  @override
  Future<Result<bool>> call(NoParams params) async {
    return await _repository.getAutoLogPreference();
  }
}
