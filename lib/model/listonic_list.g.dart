// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listonic_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListonicListAdapter extends TypeAdapter<ListonicList> {
  @override
  final int typeId = 1;

  @override
  ListonicList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListonicList(
      fields[0] as String,
      (fields[1] as List).cast<Product>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListonicList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListonicListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
