import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:cachetada/databases/playernames.dart';
import 'package:cachetada/models/tentocenter_model.dart';

part 'player_model.g.dart';

@HiveType(typeId: 1)
class PlayerModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String abv;

  @HiveField(2)
  String imageUri;

  @HiveField(3)
  List<TentoCenterModel> scores;

  @HiveField(4)
  int id;

  PlayerModel({
    this.name,
    this.abv,
    this.imageUri,
    this.scores,
    this.id,
  }) {
    if (abv == null) {
      this.getAbv();
    }
    if (scores == null) {
      scores = [];
    }
    id = Random().nextInt(99999);
  }

  getAbv() {
    print(name);
    String twoFirstNames;
    if (name.contains(' ')) {
      twoFirstNames = name.split(' ')[0][0].toUpperCase() +
          name.split(' ').last[0].toUpperCase();
    }
    String twoFirstLetter = name[0].toUpperCase() + name[1].toLowerCase();
    abv = twoFirstNames != null ? twoFirstNames : twoFirstLetter;
  }

  PlayerModel.random({int index}) {
    name = randomNames[index ?? (Random().nextInt(randomNames.length))];
    this.getAbv();
    scores = [];
    id = Random().nextInt(99999);
  }

  PlayerModel.none() {
    name = 'Livre';
    abv = '+';
    scores = [];
    id = Random().nextInt(99999);
  }



  PlayerModel copyWith({
    String name,
    String abv,
    String imageUri,
    List<TentoCenterModel> scores,
    int id,
  }) {
    return PlayerModel(
      name: name ?? this.name,
      abv: abv ?? this.abv,
      imageUri: imageUri ?? this.imageUri,
      scores: scores ?? this.scores,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abv': abv,
      'imageUri': imageUri,
      'scores': List<dynamic>.from(scores.map((x) => x.toMap())),
      'id': id,
    };
  }

  static PlayerModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PlayerModel(
      name: map['name'],
      abv: map['abv'],
      imageUri: map['imageUri'],
      scores: List<TentoCenterModel>.from(map['scores']?.map((x) => TentoCenterModel.fromMap(x))),
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static PlayerModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlayerModel(name: $name, abv: $abv, imageUri: $imageUri, scores: $scores, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is PlayerModel &&
      o.name == name &&
      o.abv == abv &&
      o.imageUri == imageUri &&
      listEquals(o.scores, scores) &&
      o.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      abv.hashCode ^
      imageUri.hashCode ^
      scores.hashCode ^
      id.hashCode;
  }
}
