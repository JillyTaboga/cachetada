// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableModelAdapter extends TypeAdapter<TableModel> {
  @override
  final typeId = 2;

  @override
  TableModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableModel(
      createTime: fields[0] as DateTime,
      players: (fields[1] as List)?.cast<PlayerModel>(),
      tableScore: (fields[3] as List)?.cast<TentoCenterModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TableModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.createTime)
      ..writeByte(1)
      ..write(obj.players)
      ..writeByte(3)
      ..write(obj.tableScore);
  }
}
