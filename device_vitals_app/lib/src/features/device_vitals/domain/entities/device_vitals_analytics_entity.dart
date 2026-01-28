import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/metrics_entity.dart';

class DeviceVitalsAnalyticsEntity {
  final MetricsEntity metrics;
  final List<DeviceVitalsEntity> series;

  DeviceVitalsAnalyticsEntity({required this.metrics, required this.series});
}
