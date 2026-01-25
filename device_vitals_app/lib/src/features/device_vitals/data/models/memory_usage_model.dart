import 'package:device_vitals_app/src/features/device_vitals/domain/entities/memory_usage_entity.dart';

class MemoryUsageModel extends MemoryUsageEntity {
  const MemoryUsageModel({super.memoryUsage});

  factory MemoryUsageModel.fromJson(Map<String, dynamic> json) {
    return MemoryUsageModel(memoryUsage: json['memory_usage']);
  }
}
