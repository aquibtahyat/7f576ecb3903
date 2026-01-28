import 'package:device_vitals_app/src/features/device_vitals/data/models/metrics_stats_model.dart';

class MetricsModel {
  final MetricsStatsModel thermal;
  final MetricsStatsModel battery;
  final MetricsStatsModel memory;

  const MetricsModel({
    required this.thermal,
    required this.battery,
    required this.memory,
  });

  factory MetricsModel.fromJson(Map<String, dynamic> json) {
    return MetricsModel(
      thermal: MetricsStatsModel.fromJson(json['thermal']),
      battery: MetricsStatsModel.fromJson(json['battery']),
      memory: MetricsStatsModel.fromJson(json['memory']),
    );
  }
}
