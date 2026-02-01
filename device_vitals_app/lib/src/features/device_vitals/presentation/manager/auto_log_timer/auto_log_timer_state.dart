import 'package:equatable/equatable.dart';

sealed class AutoLogTimerState extends Equatable {
  const AutoLogTimerState();
}

final class AutoLogTimerStopped extends AutoLogTimerState {
  final String? message;
  const AutoLogTimerStopped({this.message});

  @override
  List<Object?> get props => [message];
}

final class AutoLogTimerRunning extends AutoLogTimerState {
  final int seconds;
  final bool showSoonWarning;

  const AutoLogTimerRunning(
      {required this.seconds, this.showSoonWarning = false});

  @override
  List<Object?> get props => [seconds, showSoonWarning];
}

final class AutoLogTimerTrigger extends AutoLogTimerState {
  const AutoLogTimerTrigger();

  @override
  List<Object?> get props => [];
}
