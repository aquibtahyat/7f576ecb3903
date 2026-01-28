enum DateRange {
  last24Hours('24hrs', 'Last 24 hours'),
  last3Days('3days', 'Last 3 days'),
  last7Days('7days', 'Last 7 days'),
  last14Days('14days', 'Last 14 days'),
  last30Days('30days', 'Last 30 days');

  final String value;
  final String label;

  const DateRange(this.value, this.label);
}
