import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDB {
  static Box<PlayerModel> boxPlayers =
      Hive.box<PlayerModel>('boxPlayers');
  static Box<TableModel> boxTables =
      Hive.box<TableModel>('boxTables');

  static hiveInit() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TentoCenterModelAdapter());
    Hive.registerAdapter(PlayerModelAdapter());
    Hive.registerAdapter(TableModelAdapter());
    await Hive.openBox<PlayerModel>('boxPlayers');
    await Hive.openBox<TableModel>('boxTables');
  }

  static addTable (TableModel table){
    boxTables.add(table);
  }

  static savePlayer (PlayerModel player){
    boxPlayers.add(player);
  }
}
