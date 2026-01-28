enum ThermalStatus {
  none(0, 'Nominal'),
  light(1, 'Fair'),
  moderate(2, 'Serious'),
  severe(3, 'Critical'),
  unknown(-1, 'Unknown');

  const ThermalStatus(this.value, this.label);

  final int value;
  final String label;

  static String getLabelFromValue(int? value) {
    return ThermalStatus.values
        .firstWhere(
          (status) => status.value == value,
          orElse: () => ThermalStatus.unknown,
        )
        .label;
  }
}
