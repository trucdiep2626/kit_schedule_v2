// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentInfoAdapter extends TypeAdapter<StudentInfo> {
  @override
  final int typeId = 2;

  @override
  StudentInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentInfo(
      displayName: fields[0] as String?,
      studentCode: fields[1] as String?,
      gender: fields[2] as String?,
      birthday: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.studentCode)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.birthday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
