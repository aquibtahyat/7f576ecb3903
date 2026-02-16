class BatteryLevelModel {
  final int? batteryLevel;

  const BatteryLevelModel({this.batteryLevel});

  factory BatteryLevelModel.fromJson(Map<String, dynamic> json) {
    return BatteryLevelModel(batteryLevel: json['battery_level']);
  }
}
