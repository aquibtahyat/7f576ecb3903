class ThermalStateModel {
  final int? value;

  const ThermalStateModel({this.value});

  factory ThermalStateModel.fromJson(Map<String, dynamic> json) {
    return ThermalStateModel(value: json['value']);
  }
}
