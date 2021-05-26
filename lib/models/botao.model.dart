import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Botao {
  final int id;
  final Color cor;
  final int som;
  var tocando = false.obs;

  Botao(this.cor, this.som, this.id);
}
