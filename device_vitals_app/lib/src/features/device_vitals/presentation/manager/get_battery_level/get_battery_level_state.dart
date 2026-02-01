import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GetBatteryLevelState extends Equatable {
  const GetBatteryLevelState();
}

final class GetBatteryLevelInitial extends GetBatteryLevelState {
  const GetBatteryLevelInitial();

  @override
  List<Object?> get props => [];
}

final class GetBatteryLevelLoading extends GetBatteryLevelState {
  const GetBatteryLevelLoading();
  @override
  List<Object?> get props => [];
}

final class GetBatteryLevelSuccess extends GetBatteryLevelState {
  final BatteryLevelEntity batteryLevel;
  const GetBatteryLevelSuccess(this.batteryLevel);

  @override
  List<Object?> get props => [batteryLevel];
}

final class GetBatteryLevelFailure extends GetBatteryLevelState {
  final String message;
  final bool isLoadAll;
  const GetBatteryLevelFailure(this.message, {this.isLoadAll = false});

  @override
  List<Object?> get props => [message, isLoadAll];
}
