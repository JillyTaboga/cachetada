import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:cachetada/models/tentocenter_model.dart';
import 'package:cachetada/view/player/playercard.dart';
import 'package:cachetada/view/tentos/tentocenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  TableModel table;
  @override
  void initState() {
    super.initState();
  }

  _resetTable(){
        Provider.of<ActualTableProvider>(context, listen: false).resetTable();
  }

  Widget _tentoCreate(int id) {
    return table.tableScore.firstWhere((element) => element.id == id,
                orElse: () => null) ==
            null
        ? Container()
        : TentoCenter(
            tentoCento:
                table.tableScore.firstWhere((element) => element.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActualTableProvider>(
      builder: (context, provider, childEspecial) {
        table = provider.actualTable;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Mesa: ${DateFormat("dd 'de' MMMM 'de' yyyy").format(table.createTime)}',
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.restore_page), onPressed: _resetTable)
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: PlayerCard(player: table.players[0]),
                        ),
                        Expanded(
                          child: PlayerCard(player: table.players[1]),
                        ),
                        Expanded(
                          child: PlayerCard(player: table.players[2]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              width: 30,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: DragTarget<TentoCenterModel>(
                              onAccept: (data){
                                Provider.of<ActualTableProvider>(context, listen: false).addTableTanto(data);
                              },
                              builder: (context, listType, type) {
                                return Container(
                                  width: 500,
                                  height: 500,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _tentoCreate(0),
                                          _tentoCreate(1),
                                          _tentoCreate(2),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _tentoCreate(3),
                                          _tentoCreate(4),
                                          _tentoCreate(5),
                                          _tentoCreate(6),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          _tentoCreate(7),
                                          _tentoCreate(8),
                                          _tentoCreate(9),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ),
                          Expanded(
                            child: Text(
                                provider.actualTable.tableScore.length.toString() +
                                    '/10'),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: PlayerCard(player: table.players[3]),
                        ),
                        Expanded(
                          child: PlayerCard(player: table.players[4]),
                        ),
                        Expanded(
                          child: PlayerCard(player: table.players[5]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
