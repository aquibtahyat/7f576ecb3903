class MetricsStatsEntity {
  final num min;
  final num max;
  final num average;
  final num rollingAverage;

  const MetricsStatsEntity({
    required this.min,
    required this.max,
    required this.average,
    required this.rollingAverage,
  });
}
