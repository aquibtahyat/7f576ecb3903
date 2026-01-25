import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GetBatteryLevelState extends Equatable {
  const GetBatteryLevelState();
}

class GetBatteryLevelInitial extends GetBatteryLevelState {
  const GetBatteryLevelInitial();

  @override
  List<Object?> get props => [];
}

class GetBatteryLevelLoading extends GetBatteryLevelState {
  const GetBatteryLevelLoading();
  @override
  List<Object?> get props => [];
}

class GetBatteryLevelSuccess extends GetBatteryLevelState {
  final BatteryLevelEntity batteryLevel;
  const GetBatteryLevelSuccess(this.batteryLevel);

  @override
  List<Object?> get props => [batteryLevel];
}

class GetBatteryLevelFailure extends GetBatteryLevelState {
  final String message;
  final bool isLoadAll;
  const GetBatteryLevelFailure(this.message, {this.isLoadAll = false});

  @override
  List<Object?> get props => [message, isLoadAll];
}
