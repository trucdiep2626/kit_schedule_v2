// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_score_cell.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveScoresCellAdapter extends TypeAdapter<HiveScoresCell> {
  @override
  final int typeId = 3;

  @override
  HiveScoresCell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveScoresCell(
      name: fields[0] as String?,
      id: fields[1] as String?,
      numberOfCredits: fields[2] as int?,
      firstComponentScore: fields[3] as String?,
      alphabetScore: fields[7] as String?,
      avgScore: fields[6] as String?,
      examScore: fields[5] as String?,
      secondComponentScore: fields[4] as String?,
      isLocal: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveScoresCell obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.numberOfCredits)
      ..writeByte(3)
      ..write(obj.firstComponentScore)
      ..writeByte(4)
      ..write(obj.secondComponentScore)
      ..writeByte(5)
      ..write(obj.examScore)
      ..writeByte(6)
      ..write(obj.avgScore)
      ..writeByte(7)
      ..write(obj.alphabetScore)
      ..writeByte(8)
      ..write(obj.isLocal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveScoresCellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
