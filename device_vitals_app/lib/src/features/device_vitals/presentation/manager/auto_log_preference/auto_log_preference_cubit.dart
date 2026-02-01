import 'package:device_vitals_app/src/core/base/use_case.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/change_auto_log_preference.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/use_cases/get_auto_log_preference.dart';
import 'package:device_vitals_app/src/features/device_vitals/presentation/manager/auto_log_preference/auto_log_preference_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AutoLogPreferenceCubit extends Cubit<AutoLogPreferenceState> {
  AutoLogPreferenceCubit({
    required this.getAutoLogPreferenceUseCase,
    required this.changeAutoLogPreferenceUseCase,
  }) : super(const AutoLogPreferenceLoading());

  final GetAutoLogPreference getAutoLogPreferenceUseCase;
  final ChangeAutoLogPreference changeAutoLogPreferenceUseCase;

  Future<void> getPreference() async {
    if (!isClosed) emit(const AutoLogPreferenceLoading());

    final result = await getAutoLogPreferenceUseCase(NoParams());

    result.when(
      success: (enabled) {
        if (!isClosed) emit(AutoLogPreferenceSuccess(isEnabled: enabled));
      },
      failure: (_) {
        if (!isClosed) emit(
          const AutoLogPreferenceFailure('Failed to get auto log preference'),
        );
      },
    );
  }

  Future<void> setPreference(bool value) async {
    final result = await changeAutoLogPreferenceUseCase(value);

    result.when(
      success: (enabled) {
        if (!isClosed) emit(AutoLogPreferenceSuccess(isEnabled: enabled));
      },
      failure: (_) {
        if (!isClosed) emit(
          const AutoLogPreferenceFailure('Failed to set auto log preference'),
        );
      },
    );
  }
}
