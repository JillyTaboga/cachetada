import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:cachetada/services/hiveDB.dart';
import 'package:flutter/cupertino.dart';

class ActualTableProvider extends ChangeNotifier {

TableModel _actualTable;
TableModel get actualTable => _actualTable;

changePlayer(PlayerModel playerOld, PlayerModel playerNew){
  int indexOfOld = _actualTable.players.indexOf(playerOld);
  _actualTable.players.remove(playerOld);
  _actualTable.players.insert(indexOfOld, playerNew);
  notifyListeners();
}

loadTable(TableModel table){
  _actualTable = table;
  notifyListeners();
}

randomTable(){
  _actualTable = TableModel.newRandom(6);
  HiveDB.addTable(_actualTable);
  notifyListeners();
}

removeTableTanto(TentoCenterModel tento){
  _actualTable.tableScore.remove(tento);
  _actualTable.save();
  notifyListeners();
}

addTableTanto(TentoCenterModel tento){
  _actualTable.tableScore.add(tento);
    _actualTable.save();
  notifyListeners();
}

addTentoToPlayer(PlayerModel player, TentoCenterModel tento){
  _actualTable.players.firstWhere((element) => element==player).scores.add(tento);
    _actualTable.save();
  notifyListeners();
}

removeTentoToPlayer(PlayerModel player, TentoCenterModel tento){
  _actualTable.players.firstWhere((element) => element==player).scores.remove(tento);
    _actualTable.save();
  notifyListeners();
}

resetTable(){
      for(PlayerModel player in _actualTable.players){
      for(TentoCenterModel tento in player.scores){
        addTableTanto(tento);
      }
      player.scores = [];
    }
      _actualTable.save();
    notifyListeners();
}

}