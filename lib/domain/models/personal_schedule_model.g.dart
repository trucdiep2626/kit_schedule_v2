// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalScheduleModelAdapter extends TypeAdapter<PersonalScheduleModel> {
  @override
  final int typeId = 1;

  @override
  PersonalScheduleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalScheduleModel(
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      id: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalScheduleModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.timer)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalScheduleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
