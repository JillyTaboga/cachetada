// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tentocenter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TentoCenterModelAdapter extends TypeAdapter<TentoCenterModel> {
  @override
  final typeId = 4;

  @override
  TentoCenterModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TentoCenterModel(
      id: fields[0] as int,
      imageAsset: fields[1] as String,
      left: fields[2] as double,
      top: fields[3] as double,
      rotation: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TentoCenterModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageAsset)
      ..writeByte(2)
      ..write(obj.left)
      ..writeByte(3)
      ..write(obj.top)
      ..writeByte(4)
      ..write(obj.rotation);
  }
}
