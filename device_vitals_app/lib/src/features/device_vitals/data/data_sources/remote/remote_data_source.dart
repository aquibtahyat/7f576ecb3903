import 'package:device_vitals_app/src/core/constants/api_endpoints.dart';
import 'package:device_vitals_app/src/core/network/network_module.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_analytics_response.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_history_response.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class RemoteDataSource {
  @factoryMethod
  factory RemoteDataSource(@Named(dioClient) Dio dio) = _RemoteDataSource;

  @POST(ApiEndpoints.logDeviceVitals)
  Future<DeviceVitalsResponse> logDeviceVitals({
    @Body() required DeviceVitalsRequestModel body,
  });

  @GET(ApiEndpoints.getDeviceVitalsHistory)
  Future<DeviceVitalsHistoryResponse> getDeviceVitalsHistory({
    @Path('device_id') required String deviceId,
    @Query('limit') required int limit,
  });

  @GET(ApiEndpoints.getDeviceVitalsAnalytics)
  Future<DeviceVitalsAnalyticsResponse> getDeviceVitalsAnalytics({
    @Path('device_id') required String deviceId,
    @Query('date_range') required String dateRange,
  });
}
