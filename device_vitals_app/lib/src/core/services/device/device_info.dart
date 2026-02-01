import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_vitals_app/src/core/services/cache/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class DeviceInfo {
  Future<String> getUniqueId();
}

@LazySingleton(as: DeviceInfo)
class DeviceInfoImpl implements DeviceInfo {
  DeviceInfoImpl(this._cacheManager);

  final CacheManager _cacheManager;

  @override
  Future<String> getUniqueId() async {
    final cached = await _cacheManager.getUniqueId();
    if (cached != null && cached.isNotEmpty) return cached;

    final platformId = await _getPlatformId();
    if (platformId != null && platformId.isNotEmpty) {
      await _cacheManager.saveUniqueId(platformId);
      return platformId;
    }

    final generated = const Uuid().v4();
    await _cacheManager.saveUniqueId(generated);
    return generated;
  }

  Future<String?> _getPlatformId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
