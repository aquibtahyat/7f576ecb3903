import 'package:device_vitals_app/src/features/device_vitals/data/mappers/device_vitals_mapper.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_analytics_response.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/metrics_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/metrics_stats_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_analytics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/metrics_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/metrics_stats_entity.dart';

class DeviceVitalsAnalyticsMapper {
  static DeviceVitalsAnalyticsEntity toEntity(
    DeviceVitalsAnalyticsResponse response,
  ) {
    return DeviceVitalsAnalyticsEntity(
      metrics: _metricsFromModel(response.metrics),
      series: DeviceVitalsMapper.toEntityList(
        response.series.reversed.toList(),
      ),
    );
  }

  static MetricsEntity _metricsFromModel(MetricsModel model) {
    return MetricsEntity(
      thermal: _metricsStatsFromModel(model.thermal),
      battery: _metricsStatsFromModel(model.battery),
      memory: _metricsStatsFromModel(model.memory),
    );
  }

  static MetricsStatsEntity _metricsStatsFromModel(MetricsStatsModel model) {
    return MetricsStatsEntity(
      min: model.min,
      max: model.max,
      average: model.average,
      rollingAverage: model.rollingAverage,
    );
  }
}
