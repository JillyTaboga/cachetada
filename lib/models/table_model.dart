import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:cachetada/core/extensions.dart';
import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';

part 'table_model.g.dart';

@HiveType(typeId: 2)
class TableModel extends HiveObject {
  @HiveField(0)
  DateTime createTime;

  @HiveField(1)
  List<PlayerModel> players;

  @HiveField(3)
  List<TentoCenterModel> tableScore;

  TableModel({
    this.createTime,
    this.players,
    this.tableScore,
  });

  TableModel.newRandom(int numberOfPlayers) {
    assert(numberOfPlayers > 0);
    this.createTime = DateTime.now();
    this.players = [];
    List<int> indexesRandom = List<int>().getUnicIndexes(numberOfPlayers);
    print(indexesRandom);
    for (int i = 0; i < numberOfPlayers; i++) {
      this.players.add(PlayerModel.random(index: indexesRandom[i]));
    }
    this.tableScore = [];
    for(int i=0; i<10; i++){
      this.tableScore.add(TentoCenterModel.random(id: i));
    }
  }

  int totalTentos (){
    int total = 0;
    total += tableScore.length;
    for(PlayerModel player in players){
      total += player.scores.length;
    }
    return total;
  }

  TableModel copyWith({
    DateTime createTime,
    List<PlayerModel> players,
    List<TentoCenterModel> tableScore,
  }) {
    return TableModel(
      createTime: createTime ?? this.createTime,
      players: players ?? this.players,
      tableScore: tableScore ?? this.tableScore,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createTime': createTime.millisecondsSinceEpoch,
      'players': List<dynamic>.from(players.map((x) => x.toMap())),
      'tableScore': List<dynamic>.from(tableScore.map((x) => x.toMap())),
    };
  }

  static TableModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TableModel(
      createTime: DateTime.fromMillisecondsSinceEpoch(map['createTime']),
      players: List<PlayerModel>.from(map['players']?.map((x) => PlayerModel.fromMap(x))),
      tableScore: List<TentoCenterModel>.from(map['tableScore']?.map((x) => TentoCenterModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static TableModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'TableModel(createTime: $createTime, players: $players, tableScore: $tableScore)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TableModel &&
      o.createTime == createTime &&
      listEquals(o.players, players) &&
      listEquals(o.tableScore, tableScore);
  }

  @override
  int get hashCode => createTime.hashCode ^ players.hashCode ^ tableScore.hashCode;
}


//flutter pub run build_runner build --delete-conflicting-outputs
