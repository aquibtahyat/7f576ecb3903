import 'dart:async';

import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AutoLogTimerCubit extends Cubit<AutoLogTimerState> {
  AutoLogTimerCubit() : super(const AutoLogTimerStopped());

  Timer? _timer;
  final _autoLogInterval = Duration(seconds: 60);

  void startTimer() {
    _timer?.cancel();
    int remainingSeconds = _autoLogInterval.inSeconds;
    if (!isClosed) emit(AutoLogTimerRunning(seconds: remainingSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) {
        remainingSeconds--;
        if (remainingSeconds <= 0) {
          if (!isClosed) emit(AutoLogTimerTrigger());
          stopTimer();
          return;
        }
        if (!isClosed) {
          emit(
            AutoLogTimerRunning(
              seconds: remainingSeconds,
              showSoonWarning: remainingSeconds == 5,
            ),
          );
        }
      }
    });
  }

  void stopTimer({String? message}) {
    _timer?.cancel();
    _timer = null;
    if (!isClosed) emit(AutoLogTimerStopped(message: message));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timer = null;
    return super.close();
  }
}
