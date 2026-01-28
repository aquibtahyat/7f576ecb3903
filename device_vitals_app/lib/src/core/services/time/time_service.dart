import 'package:injectable/injectable.dart';

abstract interface class TimeProvider {
  DateTime nowUtc();
}

@LazySingleton(as: TimeProvider)
class TimeProviderImpl implements TimeProvider {
  @override
  DateTime nowUtc() => DateTime.now().toUtc();
}
