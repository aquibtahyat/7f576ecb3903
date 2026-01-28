import 'package:equatable/equatable.dart';

sealed class LogDeviceVitalsState extends Equatable {
  const LogDeviceVitalsState();
}

class LogDeviceVitalsInitial extends LogDeviceVitalsState {
  const LogDeviceVitalsInitial();

  @override
  List<Object?> get props => [];
}

class LogDeviceVitalsLoading extends LogDeviceVitalsState {
  const LogDeviceVitalsLoading();

  @override
  List<Object?> get props => [];
}

class LogDeviceVitalsSuccess extends LogDeviceVitalsState {
  const LogDeviceVitalsSuccess();
  @override
  List<Object?> get props => [];
}

class LogDeviceVitalsFailure extends LogDeviceVitalsState {
  final String message;
  const LogDeviceVitalsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
