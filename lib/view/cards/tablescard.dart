
import 'package:cachetada/models/player_model.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableCard extends StatelessWidget {
  const TableCard({
    Key key,
    @required this.table,
  }) : super(key: key);

  final TableModel table;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(DateFormat().format(table.createTime), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800),),
            SizedBox(height: 5,),
            Text('Tentos ainda na mesa: ${table.tableScore.length}/10', textAlign: TextAlign.center),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: table.players.length,
              shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 100,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 5,
                        ),
                itemBuilder: (context, index){
                  PlayerModel player = table.players[index];
                  return player==null? Container() :
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(player.name, textAlign: TextAlign.center,),
                        Text(player.scores.length.toString()),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
