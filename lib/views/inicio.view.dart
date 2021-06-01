import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playme/controllers/game.controller.dart';
import 'package:playme/views/play.view.dart';

class InicioView extends StatelessWidget {

  GameController gamecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('PLAY ME 2')),
      body: _body(),
    );
  }

  _body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:[
      _btFacil(),
      _btMedio(),
      _btDificil()
    ]);
  }
  _btFacil(){
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: (){
          gamecontroller.dificuldade.value = 1;
          Get.to(Play());
        }, child: Center(child: Text("FÁCIL"))),
      ),
    );
  }

  _btMedio(){
    return Card(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: (){
          gamecontroller.dificuldade.value = 2;
          Get.to(Play());
        }, child: Center(child: Text("Médio"))),
      ),
    );
  }

  _btDificil(){
    return Card(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: (){
          gamecontroller.dificuldade.value = 3;
          Get.to(Play());
        }, child: Center(child: Text("DIFÍCIL"))),
      ),
    );
  }
}