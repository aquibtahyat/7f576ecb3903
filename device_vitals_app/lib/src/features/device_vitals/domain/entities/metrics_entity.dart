import 'package:device_vitals_app/src/features/device_vitals/domain/entities/metrics_stats_entity.dart';

class MetricsEntity {
  final MetricsStatsEntity thermal;
  final MetricsStatsEntity battery;
  final MetricsStatsEntity memory;

  MetricsEntity({
    required this.thermal,
    required this.battery,
    required this.memory,
  });
}
