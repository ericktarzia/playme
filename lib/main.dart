import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playme/controllers/game.controller.dart';
import 'package:playme/views/inicio.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    Get.put(GameController());
    return GetMaterialApp(
      title: 'PlayMe 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InicioView(),
    );
  }
}
