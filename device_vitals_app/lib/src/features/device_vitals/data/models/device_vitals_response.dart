class DeviceVitalsResponse {
  final String? message;

  DeviceVitalsResponse({this.message});

  factory DeviceVitalsResponse.fromJson(Map<String, dynamic> json) {
    return DeviceVitalsResponse(message: json['message']);
  }
}
