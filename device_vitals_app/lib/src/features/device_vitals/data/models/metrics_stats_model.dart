class MetricsStatsModel {
  final double min;
  final double max;
  final double average;
  final double rollingAverage;

  MetricsStatsModel({
    required this.min,
    required this.max,
    required this.average,
    required this.rollingAverage,
  });

  factory MetricsStatsModel.fromJson(Map<String, dynamic> json) {
    return MetricsStatsModel(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      average: (json['average'] as num).toDouble(),
      rollingAverage: (json['rolling_average'] as num).toDouble(),
    );
  }
}
