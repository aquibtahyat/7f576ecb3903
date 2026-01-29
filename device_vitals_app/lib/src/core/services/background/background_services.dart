import 'dart:ui';

import 'package:device_vitals_app/hive_registrar.g.dart';
import 'package:device_vitals_app/src/core/constants/api_endpoints.dart';
import 'package:device_vitals_app/src/core/constants/app_constants.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_device_vitals_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapters();
    }

    final box = await Hive.openBox<CachedDeviceVitalsRequestModel>(
      AppConstants.logBox,
    );
    final entries = box.toMap().entries.toList()
      ..sort((a, b) => (a.key as String).compareTo(b.key as String));

    for (final entry in entries) {
      final key = entry.key as String;
      final log = entry.value;
      try {
        final ok = await sendLogToApi(log);
        if (ok) {
          await box.delete(key);
        } else {
          break;
        }
      } catch (e) {
        debugPrint('Background vitals flush error: $e');
        break;
      }
    }

    await box.close();
    return true;
  });
}

Future<bool> sendLogToApi(CachedDeviceVitalsRequestModel log) async {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  try {
    final res = await dio.post(
      ApiEndpoints.logDeviceVitals,
      data: log.toJson(),
    );
    return res.statusCode != null &&
        res.statusCode! >= 200 &&
        res.statusCode! < 300;
  } on DioException {
    return false;
  } catch (_) {
    return false;
  }
}
