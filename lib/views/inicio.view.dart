import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playme/controllers/game.controller.dart';
import 'package:playme/views/play.view.dart';

class InicioView extends StatelessWidget {
  GameController gamecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PLAY ME 2')),
      body: _body(),
    );
  }

  _body() {
    return ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [_logo(), _btLivre(), _btFacil(), _btMedio(), _btDificil()]);
  }

  _logo() {
    return Container(
      child: Image.asset(
        'assets/images/titulo.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  _btLivre() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            gamecontroller.dificuldade.value = 0;
            Get.to(Play());
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          child: Center(child: Text("MODO LIVRE"))),
    );
  }

  _btFacil() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            gamecontroller.dificuldade.value = 1;
            Get.to(Play());
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          child: Center(child: Text("FÁCIL"))),
    );
  }

  _btMedio() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            gamecontroller.dificuldade.value = 2;
            Get.to(Play());
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          child: Center(child: Text("NORMAL"))),
    );
  }

  _btDificil() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            gamecontroller.dificuldade.value = 3;
            Get.to(Play());
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          child: Center(child: Text("DIFÍCIL"))),
    );
  }
}
