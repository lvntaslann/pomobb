// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentModelAdapter extends TypeAdapter<ContentModel> {
  @override
  final int typeId = 1;

  @override
  ContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentModel(
      id: fields[0] as int,
      subject: fields[1] as String,
      time: fields[2] as int,
      iconPath: fields[3] as String,
      containerBgColor: fields[4] as int,
      timerPageColor: fields[5] as int,
      timerStartProgressColor: fields[6] as int,
      timerProgressColor: fields[7] as int,
      timerTextColor: fields[8] as int,
      period: fields[9] as int,
      breakTime: fields[10] as int,
      isSuccess: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContentModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.iconPath)
      ..writeByte(4)
      ..write(obj.containerBgColor)
      ..writeByte(5)
      ..write(obj.timerPageColor)
      ..writeByte(6)
      ..write(obj.timerStartProgressColor)
      ..writeByte(7)
      ..write(obj.timerProgressColor)
      ..writeByte(8)
      ..write(obj.timerTextColor)
      ..writeByte(9)
      ..write(obj.period)
      ..writeByte(10)
      ..write(obj.breakTime)
      ..writeByte(11)
      ..write(obj.isSuccess);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
