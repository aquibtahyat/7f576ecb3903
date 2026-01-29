// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_unique_id_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedUniqueIdModelAdapter extends TypeAdapter<CachedUniqueIdModel> {
  @override
  final typeId = 1;

  @override
  CachedUniqueIdModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedUniqueIdModel(uniqueId: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, CachedUniqueIdModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.uniqueId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedUniqueIdModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
