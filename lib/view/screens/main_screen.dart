import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/services/hiveDB.dart';
import 'package:cachetada/view/buttons/textbutton.dart';
import 'package:cachetada/view/dialogs/tableselect.dart';
import 'package:flutter/material.dart';
import 'package:cachetada/core/extensions.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loading = true;
  @override
  void initState() {
    _load();
    super.initState();
  }

  _load() async {
    await HiveDB.hiveInit();
    setState(() {
      loading = false;
    });
  }

  _loadTables(){
    showDialog(context: context, builder: (context){
      return TableSelect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: 250),
              child: Image.asset('assets/logo.png'),
            ),
            loading? Column(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 5,),
                Text('Carregando...')
              ],
            ) : Column(
              children: <Widget>[
                SizedBox().h15(),
                TextButton(
                  text: 'Criar Nova Partida',
                  onTap: () {
                    Provider.of<ActualTableProvider>(context, listen: false)
                        .randomTable();
                    Navigator.pushNamed(context, '/Table');
                  },
                ),
                SizedBox().h20(),
                TextButton(
                  text: 'Carregar Partida',
                  onTap: _loadTables,
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
