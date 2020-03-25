import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'tentocenter_model.g.dart';

@HiveType(typeId: 4)
class TentoCenterModel extends HiveObject {

@HiveField(0)
int id;
@HiveField(1)
String imageAsset;
@HiveField(2)
double left;
@HiveField(3)
double top;
@HiveField(4)
double rotation;

  TentoCenterModel({
    this.id,
    this.imageAsset,
    this.left,
    this.top,
    this.rotation,
  });

TentoCenterModel.random ({@required this.id}){
  imageAsset = 'assets/tentos/tento${Random().nextInt(4) + 1}.png';
  rotation = Random().nextDouble()*100;
  left = Random().nextInt(150).toDouble();
  top = Random().nextInt(150).toDouble();
}


  TentoCenterModel copyWith({
    int id,
    String imageAsset,
    double left,
    double top,
    double rotation,
  }) {
    return TentoCenterModel(
      id: id ?? this.id,
      imageAsset: imageAsset ?? this.imageAsset,
      left: left ?? this.left,
      top: top ?? this.top,
      rotation: rotation ?? this.rotation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageAsset': imageAsset,
      'left': left,
      'top': top,
      'rotation': rotation,
    };
  }

  static TentoCenterModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TentoCenterModel(
      id: map['id'],
      imageAsset: map['imageAsset'],
      left: map['left'],
      top: map['top'],
      rotation: map['rotation'],
    );
  }

  String toJson() => json.encode(toMap());

  static TentoCenterModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TentoCenterModel(id: $id, imageAsset: $imageAsset, left: $left, top: $top, rotation: $rotation)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TentoCenterModel &&
      o.id == id &&
      o.imageAsset == imageAsset &&
      o.left == left &&
      o.top == top &&
      o.rotation == rotation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      imageAsset.hashCode ^
      left.hashCode ^
      top.hashCode ^
      rotation.hashCode;
  }
}
