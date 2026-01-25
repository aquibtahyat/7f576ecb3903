import 'package:device_vitals_app/src/features/device_vitals/domain/enums/thermal_status.dart';

class ThermalStateEntity {
  final int? value;

  const ThermalStateEntity({this.value});

  String get label {
    return ThermalStatus.values
        .firstWhere(
          (e) => e.value == value,
          orElse: () =>
              ThermalStatus.unknown, // maps anything outside 0-3 to unknown
        )
        .label;
  }
}