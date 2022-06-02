// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_facts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactsAdapter extends TypeAdapter<Facts> {
  @override
  final int typeId = 0;

  @override
  Facts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Facts()
      ..facts = fields[0] as String?
      ..createdAt = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Facts obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.facts)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
