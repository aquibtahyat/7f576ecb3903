import 'package:device_vitals_app/src/core/base/result.dart';
import 'package:device_vitals_app/src/core/services/cache/cache_manager.dart';
import 'package:device_vitals_app/src/core/services/device/device_info.dart';
import 'package:device_vitals_app/src/core/services/time/time_service.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/platform/platform_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/data_sources/remote/remote_data_source.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/hive/cached_device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_response.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/repositories/device_vitals_repository_impl.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPlatformDataSource extends Mock implements PlatformDataSource {}

class _MockRemoteDataSource extends Mock implements RemoteDataSource {}

class _MockCacheManager extends Mock implements CacheManager {}

class _MockTimeProvider extends Mock implements TimeProvider {}

class _MockDeviceInfo extends Mock implements DeviceInfo {}

class _MockDeviceVitalsRequestModel extends Fake
    implements DeviceVitalsRequestModel {}

class _MockDeviceVitalsRequestModelHive extends Fake
    implements CachedDeviceVitalsRequestModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(_MockDeviceVitalsRequestModel());
    registerFallbackValue(_MockDeviceVitalsRequestModelHive());
  });

  group('Device Vitals Repository', () {
    late PlatformDataSource platformDataSource;
    late RemoteDataSource remoteDataSource;
    late CacheManager cacheManager;
    late TimeProvider timeProvider;
    late DeviceInfo deviceInfo;
    late DeviceVitalsRepositoryImpl repo;

    setUp(() {
      // Arrange
      platformDataSource = _MockPlatformDataSource();
      remoteDataSource = _MockRemoteDataSource();
      cacheManager = _MockCacheManager();
      timeProvider = _MockTimeProvider();
      deviceInfo = _MockDeviceInfo();

      when(
        () => deviceInfo.getUniqueId(),
      ).thenAnswer((_) async => 'device-123');

      repo = DeviceVitalsRepositoryImpl(
        platformDataSource,
        remoteDataSource,
        timeProvider,
        deviceInfo,
        cacheManager,
      );
    });

    group('platform', () {
      test(
        'getThermalState returns Failure when platform read fails',
        () async {
          when(() => platformDataSource.getThermalStatus()).thenThrow(
            PlatformException(
              code: 'UNAVAILABLE',
              message: 'Thermal status unavailable',
            ),
          );

          final result = await repo.getThermalState();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Thermal status unavailable',
          );
        },
      );

      test(
        'getBatteryLevel returns Failure when platform read fails',
        () async {
          when(() => platformDataSource.getBatteryLevel()).thenThrow(
            PlatformException(
              code: 'UNAVAILABLE',
              message: 'Battery level unavailable',
            ),
          );

          final result = await repo.getBatteryLevel();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Battery level unavailable',
          );
        },
      );

      test('getMemoryUsage returns Failure when platform read fails', () async {
        when(() => platformDataSource.getMemoryUsage()).thenThrow(
          PlatformException(
            code: 'UNAVAILABLE',
            message: 'Memory usage unavailable',
          ),
        );

        final result = await repo.getMemoryUsage();

        expect(result, isA<Failure>());
        expect(
          result.when(success: (_) => null, failure: (m) => m),
          'Memory usage unavailable',
        );
      });
    });

    group('device ID', () {
      test(
        'logDeviceVitals returns Failure when device ID retrieval fails',
        () async {
          when(() => deviceInfo.getUniqueId()).thenThrow(
            PlatformException(
              code: 'UNAVAILABLE',
              message: 'Device ID unavailable',
            ),
          );
          final request = DeviceVitalsRequestEntity(
            thermalValue: 0,
            batteryLevel: 50,
            memoryUsage: 0,
          );

          final result = await repo.logDeviceVitals(request: request);

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Device ID unavailable',
          );
        },
      );

      test(
        'getDeviceVitalsHistory returns Failure when device ID retrieval fails',
        () async {
          when(() => deviceInfo.getUniqueId()).thenThrow(
            PlatformException(
              code: 'UNAVAILABLE',
              message: 'Device ID unavailable',
            ),
          );

          final result = await repo.getDeviceVitalsHistory();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Device ID unavailable',
          );
        },
      );
    });

    group('cache', () {
      test(
        'logDeviceVitals throws when remote fails and cache save fails',
        () async {
          final now = DateTime.utc(2026, 01, 01, 12, 00, 00);
          when(() => timeProvider.nowUtc()).thenReturn(now);
          when(
            () => remoteDataSource.logDeviceVitals(body: any(named: 'body')),
          ).thenThrow(
            DioException(requestOptions: RequestOptions(path: '/log')),
          );
          when(
            () => cacheManager.saveLog(any()),
          ).thenThrow(Exception('Cache write failed'));
          final request = DeviceVitalsRequestEntity(
            thermalValue: 10,
            batteryLevel: 20,
            memoryUsage: 30,
          );

          await expectLater(
            repo.logDeviceVitals(request: request),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('API success and failures', () {
      test(
        'logDeviceVitals calls remote and returns Success on success',
        () async {
          final now = DateTime.utc(2026, 01, 01, 12, 00, 00);
          when(() => timeProvider.nowUtc()).thenReturn(now);
          when(
            () => remoteDataSource.logDeviceVitals(body: any(named: 'body')),
          ).thenAnswer((_) async => DeviceVitalsResponse(message: 'ok'));
          final request = DeviceVitalsRequestEntity(
            thermalValue: 10,
            batteryLevel: 20,
            memoryUsage: 30,
          );

          final result = await repo.logDeviceVitals(request: request);

          expect(result, isA<Success<void>>());

          final captured =
              verify(
                    () => remoteDataSource.logDeviceVitals(
                      body: captureAny(named: 'body'),
                    ),
                  ).captured.single
                  as DeviceVitalsRequestModel;

          expect(captured.deviceId, 'device-123');
          expect(captured.timestamp, now.toIso8601String());
          expect(captured.thermalValue, 10);
          expect(captured.batteryLevel, 20);
          expect(captured.memoryUsage, 30);

          verifyNever(() => cacheManager.saveLog(any()));
        },
      );

      test(
        'logDeviceVitals caches and returns Failure on DioException',
        () async {
          final now = DateTime.utc(2026, 01, 01, 12, 00, 00);
          when(() => timeProvider.nowUtc()).thenReturn(now);
          when(
            () => remoteDataSource.logDeviceVitals(body: any(named: 'body')),
          ).thenThrow(
            DioException(requestOptions: RequestOptions(path: '/log')),
          );
          when(() => cacheManager.saveLog(any())).thenAnswer((_) async => 'k');
          final request = DeviceVitalsRequestEntity(
            thermalValue: 10,
            batteryLevel: 20,
            memoryUsage: 30,
          );

          final result = await repo.logDeviceVitals(request: request);

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Failed to log device vitals due to connection error, will try again later',
          );

          verify(() => cacheManager.saveLog(any())).called(1);
        },
      );

      test(
        'getDeviceVitalsHistory returns Failure with timeout message when remote times out',
        () async {
          when(
            () => remoteDataSource.getDeviceVitalsHistory(
              deviceId: any(named: 'deviceId'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/history'),
              type: DioExceptionType.receiveTimeout,
            ),
          );

          final result = await repo.getDeviceVitalsHistory();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Server response timed out. Please try again later.',
          );
        },
      );

      test(
        'getDeviceVitalsHistory returns Failure with server error message when remote returns 500',
        () async {
          when(
            () => remoteDataSource.getDeviceVitalsHistory(
              deviceId: any(named: 'deviceId'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(
            DioException(
              requestOptions: RequestOptions(path: '/history'),
              response: Response(
                requestOptions: RequestOptions(path: '/history'),
                statusCode: 500,
              ),
              type: DioExceptionType.badResponse,
            ),
          );

          final result = await repo.getDeviceVitalsHistory();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'Server error. Please try again later.',
          );
        },
      );

      test(
        'getDeviceVitalsHistory returns Failure with parse message when remote response is invalid',
        () async {
          when(
            () => remoteDataSource.getDeviceVitalsHistory(
              deviceId: any(named: 'deviceId'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(const FormatException('Invalid JSON'));

          final result = await repo.getDeviceVitalsHistory();

          expect(result, isA<Failure>());
          expect(
            result.when(success: (_) => null, failure: (m) => m),
            'We received data we couldn\'t understand. Please try again.',
          );
        },
      );

      test(
        'logDeviceVitals succeeds with edge case values (battery 0, 100, thermal 0-3, memory 0)',
        () async {
          final now = DateTime.utc(2026, 01, 01, 12, 00, 00);
          when(() => timeProvider.nowUtc()).thenReturn(now);
          when(
            () => remoteDataSource.logDeviceVitals(body: any(named: 'body')),
          ).thenAnswer((_) async => DeviceVitalsResponse(message: 'ok'));
          final request = DeviceVitalsRequestEntity(
            thermalValue: 0,
            batteryLevel: 0,
            memoryUsage: 0,
          );

          final result = await repo.logDeviceVitals(request: request);

          expect(result, isA<Success<void>>());
          final captured =
              verify(
                    () => remoteDataSource.logDeviceVitals(
                      body: captureAny(named: 'body'),
                    ),
                  ).captured.single
                  as DeviceVitalsRequestModel;
          expect(captured.thermalValue, 0);
          expect(captured.batteryLevel, 0);
          expect(captured.memoryUsage, 0);
        },
      );

      test('logDeviceVitals succeeds with battery 100 and thermal 3', () async {
        final now = DateTime.utc(2026, 01, 01, 12, 00, 00);
        when(() => timeProvider.nowUtc()).thenReturn(now);
        when(
          () => remoteDataSource.logDeviceVitals(body: any(named: 'body')),
        ).thenAnswer((_) async => DeviceVitalsResponse(message: 'ok'));
        final request = DeviceVitalsRequestEntity(
          thermalValue: 3,
          batteryLevel: 100,
          memoryUsage: 99,
        );

        final result = await repo.logDeviceVitals(request: request);

        expect(result, isA<Success<void>>());
        final captured =
            verify(
                  () => remoteDataSource.logDeviceVitals(
                    body: captureAny(named: 'body'),
                  ),
                ).captured.single
                as DeviceVitalsRequestModel;
        expect(captured.thermalValue, 3);
        expect(captured.batteryLevel, 100);
        expect(captured.memoryUsage, 99);
      });
    });
  });
}
