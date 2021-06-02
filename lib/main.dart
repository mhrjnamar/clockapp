import 'package:clockapp/enums.dart';
import 'package:clockapp/models/menu_info.dart';
import 'package:clockapp/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print('log');
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: ChangeNotifierProvider<MenuInfo>(
          create: (BuildContext context) => MenuInfo(MenuType.clock),
          child: HomePage()),
    );
  }
}
