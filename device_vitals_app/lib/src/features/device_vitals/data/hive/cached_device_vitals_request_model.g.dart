// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_device_vitals_request_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedDeviceVitalsRequestModelAdapter
    extends TypeAdapter<CachedDeviceVitalsRequestModel> {
  @override
  final typeId = 0;

  @override
  CachedDeviceVitalsRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedDeviceVitalsRequestModel(
      deviceId: fields[0] as String,
      timestamp: fields[1] as String,
      thermalValue: (fields[2] as num).toInt(),
      batteryLevel: (fields[3] as num).toInt(),
      memoryUsage: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CachedDeviceVitalsRequestModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.deviceId)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.thermalValue)
      ..writeByte(3)
      ..write(obj.batteryLevel)
      ..writeByte(4)
      ..write(obj.memoryUsage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedDeviceVitalsRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
