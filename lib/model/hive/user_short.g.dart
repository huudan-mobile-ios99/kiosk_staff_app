// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserShortAdapter extends TypeAdapter<UserShort> {
  @override
  final int typeId = 0;

  @override
  UserShort read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserShort(
      name: fields[0] as String?,
      number: fields[1] as int?,
      createAt: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserShort obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserShortAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
