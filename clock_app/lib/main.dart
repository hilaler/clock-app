import 'package:clock_app/enums.dart';
import 'package:clock_app/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(
          MenuType.clock,
          title: '',
          imageSource: '',
        ),
        child: HomePage(),
      ),
    );
  }
}
