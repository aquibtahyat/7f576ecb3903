import 'package:device_vitals_app/src/features/device_vitals/data/models/thermal_state_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';

class ThermalStateMapper {
  static ThermalStateEntity toEntity(ThermalStateModel model) {
    return ThermalStateEntity(value: model.value);
  }
}
