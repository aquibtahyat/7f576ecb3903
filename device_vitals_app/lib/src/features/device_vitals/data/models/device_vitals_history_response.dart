import 'package:device_vitals_app/src/core/pagination/pagination.dart';
import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_model.dart';

class DeviceVitalsHistoryResponse {
  final String message;
  final Pagination pagination;
  final List<DeviceVitalsModel> data;

  DeviceVitalsHistoryResponse({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory DeviceVitalsHistoryResponse.fromJson(Map<String, dynamic> json) =>
      DeviceVitalsHistoryResponse(
        message: json["message"],
        pagination: Pagination.fromJson(json["pagination"]),
        data: json["data"] == null || json["data"].isEmpty
            ? []
            : List<DeviceVitalsModel>.from(
                json["data"]!.map((x) => DeviceVitalsModel.fromJson(x)),
              ),
      );
}
