import 'package:device_vitals_app/app.dart';
import 'package:device_vitals_app/src/core/injection/dependencies.dart';
import 'package:device_vitals_app/src/core/services/background/background_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Workmanager().initialize(callbackDispatcher);

  await Workmanager().registerPeriodicTask(
    'vitals-sync-periodic',
    'vitalsSyncTask',
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.connected),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );
  await DependencyManager.inject();
  runApp(const App());
}
