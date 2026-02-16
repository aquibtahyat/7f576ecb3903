class MemoryUsageModel {
  final int? memoryUsage;

  const MemoryUsageModel({this.memoryUsage});

  factory MemoryUsageModel.fromJson(Map<String, dynamic> json) {
    return MemoryUsageModel(memoryUsage: json['memory_usage']);
  }
}
