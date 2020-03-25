import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/models/table_model.dart';
import 'package:cachetada/services/hiveDB.dart';
import 'package:cachetada/view/cards/tablescard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class TableSelect extends StatefulWidget {
  @override
  _TableSelectState createState() => _TableSelectState();
}

class _TableSelectState extends State<TableSelect> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            'Mesas salvas',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<TableModel>>(
              valueListenable: HiveDB.boxTables.listenable(),
              builder: (context, box, especialChild) {
                List<TableModel> tables = box.values.toList();
                tables.sort((a, b) => b.createTime.compareTo(a.createTime));
                return tables.length < 1
                    ? Center(child: Text('Nenhuma mesa salva'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: tables.length,
                        itemBuilder: (context, index) {
                          TableModel table = tables[index];
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<ActualTableProvider>(context, listen: false).loadTable(table);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/Table');
                                  },
                                  child: TableCard(table: table)),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    table.delete();
                                  }),
                            ],
                          );
                        });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
