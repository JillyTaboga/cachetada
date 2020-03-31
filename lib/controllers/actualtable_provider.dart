import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:cachetada/services/hiveDB.dart';
import 'package:flutter/cupertino.dart';

class ActualTableProvider extends ChangeNotifier {
  TableModel _actualTable; //Mesa que será exibida na tela da mesa
  TableModel get actualTable => _actualTable;

//Método que troca um player por outro
  changePlayer(PlayerModel playerOld, PlayerModel playerNew) {
    int indexOfOld = _actualTable.players.indexOf(playerOld); //Necessário para inserir o novo jogador no mesmo lugar do retirado
    _actualTable.players.remove(playerOld);
    _actualTable.players.insert(indexOfOld, playerNew);
    notifyListeners();
  }

//Insere uma mesa salva como a atual
  loadTable(TableModel table) {
    _actualTable = table;
    notifyListeners();
  }

//Cria uma mesa aleatória e a coloca como a atual
  randomTable() {
    _actualTable = TableModel.newRandom(6);
    HiveDB.addTable(_actualTable);
    notifyListeners();
  }

//Métodos para acionar tento na mesa ou remover
  removeTableTanto(TentoCenterModel tento) {
    _actualTable.tableScore.remove(tento);
    _actualTable.save();
    notifyListeners();
  }
  addTableTanto(TentoCenterModel tento) {
    _actualTable.tableScore.add(tento);
    _actualTable.save();
    notifyListeners();
  }

//Adciona tento a um player ou remove
  addTentoToPlayer(PlayerModel player, TentoCenterModel tento) {
    _actualTable.players
        .firstWhere((element) => element == player)
        .scores
        .add(tento);
    _actualTable.save();
    notifyListeners();
  }
  removeTentoToPlayer(PlayerModel player, TentoCenterModel tento) {
    _actualTable.players
        .firstWhere((element) => element == player)
        .scores
        .remove(tento);
    _actualTable.save();
    notifyListeners();
  }

//Retira todos os tentos dos jogadores e coloca eles na mesa
  resetTable() {
    for (PlayerModel player in _actualTable.players) {
      for (TentoCenterModel tento in player.scores) {
        addTableTanto(tento);
      }
      player.scores = [];
    }
    _actualTable.save();
    notifyListeners();
  }
}
