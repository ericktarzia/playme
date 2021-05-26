import 'package:flutter/material.dart';
import 'package:playme/views/play.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlayMe 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Play(),
    );
  }
}
