import 'package:device_vitals_app/src/core/injection/injector.dart';

class DependencyManager {
  static Future<void> inject() async {
    await configureDependencies();
  }
}
