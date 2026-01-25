import 'package:device_vitals_app/src/features/device_vitals/domain/entities/thermal_state_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GetThermalStateState extends Equatable {
  const GetThermalStateState();
}

class GetThermalStateInitial extends GetThermalStateState {
  const GetThermalStateInitial();

  @override
  List<Object?> get props => [];
}

class GetThermalStateLoading extends GetThermalStateState {
  const GetThermalStateLoading();
  @override
  List<Object?> get props => [];
}

class GetThermalStateSuccess extends GetThermalStateState {
  final ThermalStateEntity thermalState;
  const GetThermalStateSuccess(this.thermalState);

  @override
  List<Object?> get props => [thermalState];
}

class GetThermalStateFailure extends GetThermalStateState {
  final String message;
  final bool isLoadAll;

  const GetThermalStateFailure(this.message, {this.isLoadAll = false});

  @override
  List<Object?> get props => [message, isLoadAll];
}
