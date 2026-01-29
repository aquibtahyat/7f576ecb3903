import 'dart:async';

import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_timer/auto_log_timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AutoLogTimerCubit extends Cubit<AutoLogTimerState> {
  AutoLogTimerCubit() : super(const AutoLogTimerStopped());

  Timer? _timer;
  final _autoLogInterval = Duration(minutes: 10);

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_autoLogInterval, (_) {
      emit(AutoLogTimerTrigger());
      if (!isClosed) emit(const AutoLogTimerRunning());
    });
    emit(const AutoLogTimerRunning());
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    emit(const AutoLogTimerStopped());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timer = null;
    return super.close();
  }
}
