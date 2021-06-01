import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playme/controllers/game.controller.dart';
import 'package:playme/models/botao.model.dart';
import 'package:playme/views/inicio.view.dart';
import 'dart:math';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';

class Play extends StatelessWidget {
  GameController _gameController = Get.find();
  Soundpool pool;
  Random random;
  final aguarde = true.obs;
  final toques = 0.obs;
  var status = "AGUARDE".obs;

  var listaParaTocar = [].obs;
  final sequencia = [].obs;
  var tocados = [].obs;
  var score = 0.obs;

  var controleDaSequencia = 0.obs;

  int somA, somB, somC, somD, somE, somF, somErro;
  List<Botao> _listaBotoes;

  var isLoading = true.obs;

  Play() {
    carregarSons();
  }

  carregarSons() async {
    print("carregando");
    random = new Random();
    pool = Soundpool(streamType: StreamType.notification);
    somA =
        await rootBundle.load("assets/sounds/a.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    somB =
        await rootBundle.load("assets/sounds/b.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    somC =
        await rootBundle.load("assets/sounds/c.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    somD =
        await rootBundle.load("assets/sounds/d.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    somE =
        await rootBundle.load("assets/sounds/e.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    somF =
        await rootBundle.load("assets/sounds/f.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });

    somErro = await rootBundle
        .load("assets/sounds/erro.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });

    _listaBotoes = <Botao>[
      Botao(Colors.greenAccent, somA, 1),
      Botao(Colors.amberAccent, somB, 2),
      Botao(Colors.blueAccent, somC, 3),
      Botao(Colors.cyanAccent, somD, 4),
    ];
    isLoading.value = false;
    if (_gameController.dificuldade > 1 ||
        _gameController.dificuldade.value == 0) {
      _listaBotoes.add(Botao(Colors.deepOrangeAccent, somE, 5));
      _listaBotoes.add(Botao(Colors.purple, somF, 6));
    }
    _gameController.dificuldade.value == 0
        ? passaAVez()
        : Future.delayed(Duration(seconds: 3), _gerarNumero());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text("SCORE: ${score.value}"),
          ),
          body: (isLoading.value)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Container(
                        height: 50,
                        child: Obx(() => Center(child: Text(status.value)))),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                            // margin: EdgeInsets.only(top: 50),
                            child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                                children:
                                    List.generate(_listaBotoes.length, (index) {
                                  return Container(
                                    child: _botao(_listaBotoes[index]),
                                  );
                                }))),
                      ),
                    ),
                  ],
                )),
    );
  }

  _botao(Botao botao) {
    return Obx(
      () => AnimatedOpacity(
        opacity: (botao.tocando.value) ? 1.0 : 0.2,
        duration: Duration(milliseconds: 300),
        child: Card(
          color: botao.cor,
          child: InkWell(
            onTap: (aguarde.value)
                ? null
                : () {
                    tocados.add(botao.id);
                    toques.value++;
                    playBotao(botao, 0);
                  },
            child: Container(),
          ),
        ),
      ),
    );
  }

  _gerarNumero() {
    int randomNumber =
        random.nextInt((_gameController.dificuldade > 1) ? 5 : 3);
    listaParaTocar.add(randomNumber + 1);
    _tocar(randomNumber + 1);
  }

  void _tocar(int numeroATocar) async {
    sequencia.add(numeroATocar);

    sequencia.asMap().forEach((index, nSequencia) async {
      _listaBotoes.where((element) {
        if (element.id == nSequencia) {
          playBotao(element, index);

          return true;
        }
        return false;
      }).toList();
    });
    passaAVez();
  }

  void passaAVez() {
    Future.delayed(Duration(seconds: 1), () => aguarde.value = false);
    Future.delayed(Duration(seconds: 1), () => status.value = "SUA VEZ");
    print(sequencia.toString());
  }

  playBotao(Botao botao, int numeroNaSequencia) async {
    int numeros = sequencia.length;

    Future.delayed(Duration(seconds: 1 * numeroNaSequencia), () {
      pool.play(botao.som);
      botao.tocando.value = true;
    });
    Future.delayed(Duration(seconds: 1 * 1 + numeroNaSequencia), () {
      pool.stop(botao.som);
      botao.tocando.value = false;
    });

    if (numeros == toques.value) {
      print("sequencia: " + sequencia.toString());
      print("tocados: " + tocados.toString());
      aguarde.value = true;

      if (listEquals(sequencia, tocados)) {
        score++;

        status.value = "AGUARDE";
        toques.value = 0;

        Future.delayed(Duration(seconds: 2), () {
          tocados.value = [];
          if (_gameController.dificuldade.value == 3) {
            _listaBotoes.shuffle();
          }
          _gerarNumero();
        });
      } else {
        _erro();
      }
    }
  }

  _erro() {
    return Get.defaultDialog(
        title: 'ERROU!',
        onConfirm: () => Get.offAll(InicioView()),
        onCancel: () => Get.offAll(InicioView()),
        barrierDismissible: false,
        content: Center(child: Text("${score.value} pontos!")));
  }
}
