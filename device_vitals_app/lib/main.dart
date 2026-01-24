import 'package:device_vitals_app/app.dart';
import 'package:device_vitals_app/src/core/injection/dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyManager.inject();
  runApp(const App());
}
