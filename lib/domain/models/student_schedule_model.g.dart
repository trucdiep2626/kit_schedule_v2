// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentScheduleAdapter extends TypeAdapter<StudentSchedule> {
  @override
  final int typeId = 0;

  @override
  StudentSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentSchedule(
      day: fields[0] as String?,
      subjectCode: fields[1] as String?,
      subjectName: fields[2] as String?,
      className: fields[3] as String?,
      teacher: fields[4] as String?,
      lesson: fields[5] as String?,
      room: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentSchedule obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.subjectCode)
      ..writeByte(2)
      ..write(obj.subjectName)
      ..writeByte(3)
      ..write(obj.className)
      ..writeByte(4)
      ..write(obj.teacher)
      ..writeByte(5)
      ..write(obj.lesson)
      ..writeByte(6)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
