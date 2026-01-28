import 'package:device_vitals_app/src/core/network/network_module.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class RemoteDataSource {
  @factoryMethod
  factory RemoteDataSource(@Named(dioClient) Dio dio) = _RemoteDataSource;
}
