import 'package:device_vitals_app/src/core/constants/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const dioClient = 'DIOCLIENT';

Dio _createBaseDio() {
  final dio = Dio()
    ..options.baseUrl = ApiEndpoints.baseUrl
    ..options.connectTimeout = const Duration(seconds: 10)
    ..options.receiveTimeout = const Duration(seconds: 20)
    ..options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

  return dio;
}

final logger = PrettyDioLogger(requestHeader: true, requestBody: true);

@module
abstract class NetworkModule {
  @singleton
  @Named(dioClient)
  Dio getDio() {
    final dio = _createBaseDio()..interceptors.addAll([logger]);
    return dio;
  }
}
