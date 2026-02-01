import 'package:equatable/equatable.dart';

sealed class LogDeviceVitalsState extends Equatable {
  const LogDeviceVitalsState();
}

final class LogDeviceVitalsInitial extends LogDeviceVitalsState {
  const LogDeviceVitalsInitial();

  @override
  List<Object?> get props => [];
}

final class LogDeviceVitalsLoading extends LogDeviceVitalsState {
  const LogDeviceVitalsLoading();

  @override
  List<Object?> get props => [];
}

final class LogDeviceVitalsSuccess extends LogDeviceVitalsState {
  final bool isAutoLog;

  const LogDeviceVitalsSuccess({this.isAutoLog = false});
  @override
  List<Object?> get props => [isAutoLog];
}

final class LogDeviceVitalsFailure extends LogDeviceVitalsState {
  final String message;
  const LogDeviceVitalsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
