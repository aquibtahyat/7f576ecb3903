import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';
import 'package:equatable/equatable.dart';

sealed class GetHistoryState extends Equatable {
  const GetHistoryState();
}

final class GetHistoryInitial extends GetHistoryState {
  const GetHistoryInitial();

  @override
  List<Object?> get props => [];
}

final class GetHistoryLoading extends GetHistoryState {
  const GetHistoryLoading();

  @override
  List<Object?> get props => [];
}

final class GetHistorySuccess extends GetHistoryState {
  final List<DeviceVitalsEntity> history;
  const GetHistorySuccess(this.history);

  @override
  List<Object?> get props => [history];
}

final class GetHistoryFailure extends GetHistoryState {
  final String message;

  const GetHistoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}
