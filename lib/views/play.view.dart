import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playme/models/botao.model.dart';
import 'dart:math';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class Play extends StatelessWidget {
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

  int somA, somB, somC, somD, somE, somF;
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

    _listaBotoes = <Botao>[
      Botao(Colors.greenAccent, somA, 1),
      Botao(Colors.amberAccent, somB, 2),
      Botao(Colors.blueAccent, somC, 3),
      Botao(Colors.cyanAccent, somD, 4),
      Botao(Colors.deepOrangeAccent, somE, 5),
      Botao(Colors.purple, somF, 6),
    ];
    isLoading.value = false;
    _gerarNumero();
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
                    Container(height: 50, child: Obx(() => Text(status.value))),
                    Container(
                        child: GridView.count(
                            crossAxisCount: 2,
                            children:
                                List.generate(_listaBotoes.length, (index) {
                              return Container(
                                child: _botao(_listaBotoes[index]),
                              );
                            }))),
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
            child: Container(
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }

  _gerarNumero() {
    int randomNumber = random.nextInt(5);
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
        print("acertou");
      } else {
        print("errou");
      }

      status.value = "AGUARDE";
      toques.value = 0;

      Future.delayed(Duration(seconds: 2), () {
        tocados.value = [];
        _gerarNumero();
      });
    }
  }
}
