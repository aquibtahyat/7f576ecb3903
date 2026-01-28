import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/metrics_model.dart';

class DeviceVitalsAnalyticsResponse {
  final MetricsModel metrics;
  final List<DeviceVitalsModel> series;

  DeviceVitalsAnalyticsResponse({required this.metrics, required this.series});

  factory DeviceVitalsAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return DeviceVitalsAnalyticsResponse(
      metrics: MetricsModel.fromJson(json['metrics']),
      series: List<DeviceVitalsModel>.from(
        json['series'].map((x) => DeviceVitalsModel.fromJson(x)),
      ),
    );
  }
}
