class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://sevenf576ecb3903.onrender.com';
  static const String logDeviceVitals = '/api/vitals';
  static const String getDeviceVitalsHistory = '/api/vitals/{device_id}';
  static const String getDeviceVitalsAnalytics =
      '/api/vitals/analytics/{device_id}';
}
