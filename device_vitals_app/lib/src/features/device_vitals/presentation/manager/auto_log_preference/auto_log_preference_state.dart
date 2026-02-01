import 'package:equatable/equatable.dart';

sealed class AutoLogPreferenceState extends Equatable {
  const AutoLogPreferenceState();
}

final class AutoLogPreferenceLoading extends AutoLogPreferenceState {
  const AutoLogPreferenceLoading();

  @override
  List<Object?> get props => [];
}

final class AutoLogPreferenceSuccess extends AutoLogPreferenceState {
  final bool isEnabled;

  const AutoLogPreferenceSuccess({required this.isEnabled});

  @override
  List<Object?> get props => [isEnabled];
}

final class AutoLogPreferenceFailure extends AutoLogPreferenceState {
  final String message;

  const AutoLogPreferenceFailure(this.message);

  @override
  List<Object?> get props => [message];
}
