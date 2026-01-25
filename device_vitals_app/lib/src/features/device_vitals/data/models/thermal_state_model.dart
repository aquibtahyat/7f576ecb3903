import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';

class ThermalStateModel extends ThermalStateEntity {
  const ThermalStateModel({super.value});

  factory ThermalStateModel.fromJson(Map<String, dynamic> json) {
    return ThermalStateModel(value: json['value']);
  }
}
