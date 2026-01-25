import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/repositories/device_vitals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMemoryUsage implements UseCase<Result<MemoryUsageEntity>, NoParams> {
  final DeviceVitalsRepository _repository;

  GetMemoryUsage(this._repository);

  @override
  Future<Result<MemoryUsageEntity>> call(NoParams params) async {
    return await _repository.getMemoryUsage();
  }
}
