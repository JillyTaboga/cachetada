import 'package:cachetada/controllers/actualtable_provider.dart';
import 'package:cachetada/view/screens/main_screen.dart';
import 'package:cachetada/view/screens/table_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('pt_BR', null);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ActualTableProvider>(
          create: (context) => ActualTableProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.green.shade900,
            splashColor: Colors.greenAccent),
        routes: {
          '/': (context) => MainScreen(),
          '/Table': (context) => TableScreen(),
        },
      ),
    );
  }
}
