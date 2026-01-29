import 'package:equatable/equatable.dart';

sealed class AutoLogTimerState extends Equatable {
  const AutoLogTimerState();

  @override
  List<Object?> get props => [];
}

final class AutoLogTimerStopped extends AutoLogTimerState {
  const AutoLogTimerStopped();
}

final class AutoLogTimerRunning extends AutoLogTimerState {
  const AutoLogTimerRunning();
}

final class AutoLogTimerTrigger extends AutoLogTimerState {
  const AutoLogTimerTrigger();

  @override
  List<Object?> get props => [];
}
