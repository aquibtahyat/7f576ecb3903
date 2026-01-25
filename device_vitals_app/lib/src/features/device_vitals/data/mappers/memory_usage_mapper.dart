import 'package:device_vitals_app/src/features/device_vitals/data/models/memory_usage_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';

class MemoryUsageMapper {
  static MemoryUsageEntity toEntity(MemoryUsageModel model) {
    return MemoryUsageEntity(memoryUsage: model.memoryUsage);
  }
}
