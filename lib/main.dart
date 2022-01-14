import 'package:flutter/material.dart';
import './user_current_lcation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'OpenStreetMap'),
      home: UserCurrentLocation(),
    );
  }
}
