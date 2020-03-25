// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerModelAdapter extends TypeAdapter<PlayerModel> {
  @override
  final typeId = 1;

  @override
  PlayerModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerModel(
      name: fields[0] as String,
      abv: fields[1] as String,
      imageUri: fields[2] as String,
      scores: (fields[3] as List)?.cast<TentoCenterModel>(),
      id: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.abv)
      ..writeByte(2)
      ..write(obj.imageUri)
      ..writeByte(3)
      ..write(obj.scores)
      ..writeByte(4)
      ..write(obj.id);
  }
}
