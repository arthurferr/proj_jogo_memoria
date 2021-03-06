import 'dart:async';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/helper/flip_card.dart';
import 'package:proj_jogo_memoria/telas/tela_inicial.dart';

class ParSelecionado {
  int indice1;
  int indice2;

  ParSelecionado(this.indice1, this.indice2);
}

class TelaJogo extends StatefulWidget {
  final int numeroPares;

  const TelaJogo({Key? key, required this.numeroPares}) : super(key: key);

  @override
  _TelaJogoState createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  Map<int, bool> _indicesVirados = {};
  Map<int, String> _imagensViradas = {};
  List<ParSelecionado> _paresSelecionados = [];
  Map<int, GlobalKey<FlipCardState>> _mapController = {};
  final List<String> _listaImagens = [
    "Imagens_Projeto/imagem_1.jpg",
    "Imagens_Projeto/imagem_2.jpg",
    "Imagens_Projeto/imagem_3.jpg",
    "Imagens_Projeto/imagem_4.jpg",
    "Imagens_Projeto/imagem_5.jpg",
    "Imagens_Projeto/imagem_6.jpg",
    "Imagens_Projeto/imagem_7.jpg",
    "Imagens_Projeto/imagem_8.jpg",
    "Imagens_Projeto/imagem_9.jpg",
    "Imagens_Projeto/imagem_10.jpg",
    "Imagens_Projeto/imagem_12.jpg",
    "Imagens_Projeto/imagem_13.jpg",
  ];
  late List<String> _imagensSorteadas;

  List<String> _pegarListImagens(int numeroPares) {
    Random ramdom1 = Random(DateTime
        .now()
        .millisecondsSinceEpoch);
    List<String> bancoImagens = [..._listaImagens];
    bancoImagens.shuffle(ramdom1);
    List<String> copia = [...bancoImagens.sublist(0, numeroPares)];
    copia.shuffle(ramdom1);
    List<String> imagens = [...copia];
    Random ramdom2 = Random(DateTime
        .now()
        .subtract(Duration(days: 365 * 10))
        .millisecondsSinceEpoch);
    copia.shuffle(ramdom2);
    imagens = [...imagens, ...copia];
    return imagens;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagensSorteadas = _pegarListImagens(widget.numeroPares);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      // Container(
      //     // margin: EdgeInsets.only(top: MediaQuery
      //     //     .of(context)
      //     //     .padding
      //     //     .top),
      //     // decoration: BoxDecoration(
      //     //     gradient: LinearGradient(
      //     //       begin: Alignment.topCenter,
      //     //       end: Alignment.bottomCenter,
      //     //       colors: [
      //     //         Colors.lightGreenAccent,
      //     //         Colors.pinkAccent,
      //     //       ],
      //     //     )),
      //     child: Column(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           _body(),
      //           //Expanded(flex: , child: _body()),
      //           // Expanded(
      //           //   flex: 1,
      //           //   child: _button(
      //           //       text: "Voltar",
      //           //       onPressed: () {
      //           //         Navigator.pushAndRemoveUntil(context,
      //           //             MaterialPageRoute(
      //           //                 builder: (BuildContext context) {
      //           //                   return TelaInicial();
      //           //                 }), (route) => false);
      //           //       }),
      //           // ),
      //         ]
      //     )
      // )
    );
  }

  _virarImagem(int indice, String imagem, bool isFrontImage,
      GlobalKey<FlipCardState> cardKey) {
    _mapController.putIfAbsent(indice, () => cardKey);

    /// Desvirando uma carta j?? selecionada
    if (!isFrontImage) {
      _indicesVirados.remove(indice);
      _imagensViradas.remove(indice);
      return;
    }

    /// Primeira carta selecionada de um para (essa carta ser?? comparada com a carta seguinte)
    if (_indicesVirados.length % 2 == 0) {
      _indicesVirados.putIfAbsent(indice, () => true);
      _imagensViradas.putIfAbsent(indice, () => imagem);
    } else {
      /// Segunda carta selecionada
      List<MapEntry<int, String>> entries = _imagensViradas.entries
          .where((element) => element.key != indice && element.value == imagem)
          .toList();
      if (entries.length > 0) {
        /// Se as cartas formam um par v??lido ela ser?? adicionada no Array de paresSelecionados
        MapEntry<int, String> entry = entries[0];
        _indicesVirados.putIfAbsent(indice, () => true);
        _imagensViradas.putIfAbsent(indice, () => imagem);
        setState(() {
          _paresSelecionados.add(ParSelecionado(entry.key, indice));
        });
      } else {
        /// Logica para desvirar as cartas selecionadas que n??o formam um par v??lido
        List<int> indicesParesSelecionados = [];
        if (_paresSelecionados.length > 0) {
          _paresSelecionados.forEach((element) {
            indicesParesSelecionados.add(element.indice1);
            indicesParesSelecionados.add(element.indice2);
          });
        }

        /// Encontra os indices das cartas que n??o formam um par para poder remover da lista de cartas selecionadas
        List<int> indicesRemover = [];
        _indicesVirados.entries.forEach((element) {
          if (!indicesParesSelecionados.contains(element.key)) {
            indicesRemover.add(element.key);
          }
        });

        /// Remove da lista as cartas que n??o formam um par e desvira essas cartas
        indicesRemover.forEach((element) {
          if (_mapController.containsKey(element)) {
            _mapController[element]!.currentState!.toggleCard();
          }
          _indicesVirados.remove(element);
          _imagensViradas.remove(element);
        });

        /// Desvira a ultima carta selecionada caso n??o forme um par v??lido (Opera????o Ass??ncrona)
        Timer(Duration(milliseconds: 300), () {
          cardKey!.currentState!.toggleCard();
        });
      }
    }
  }

  _exibirDialogoFimDeJogo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.lightGreenAccent,
          elevation: 0,
          child: _dialog(context),
        );
      },
    );
  }

  _dialog(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: [
          Expanded(flex: 2, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Parabens Voc?? Ganhou!\nDeseja Jogar Novamente?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent),
              )
            ],
          )),
          Expanded(
              flex: 6,
              child: Image.asset(
                "Imagens_Projeto/Verso.jpg",
              )),
          Expanded(flex: 2, child: _botoesDialog()),
        ],
      ),
    );
  }

  _botoesDialog() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('N??o'),
        ),
        TextButton(
          style: TextButton.styleFrom(
              elevation: 15, backgroundColor: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TelaInicial();
                    }), (route) => false);
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }

  _body() {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .padding
            .top),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.lightGreenAccent,
                Colors.greenAccent,
              ],
            )),
        child:
        Column(
          children: [
            Expanded(flex: 6,
              child: GridView.extent(
              maxCrossAxisExtent: _axisParam(widget.numeroPares),
              children: [
                ..._imagensSorteadas
                    .asMap()
                    .entries
                    .map((entry) {
                  int indice = entry.key;
                  String imagem = entry.value;
                  bool existePar = _paresSelecionados
                      .where((element) =>
                  element.indice1 == indice || element.indice2 == indice)
                      .toList()
                      .length >
                      0;
                  return Flip_Card(
                      "Imagens_Projeto/Verso.jpg", imagem, !existePar,
                      onFlipDone: (cardState, isFrontImage) {
                        _virarImagem(indice, imagem, isFrontImage, cardState);
                        if (widget.numeroPares == _paresSelecionados.length) {
                          _exibirDialogoFimDeJogo(context);
                        }
                      });
                }).toList(),
              ],
            ),
            ),
            Expanded(flex: 1,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_botaoVoltar(text: "Voltar", onPressed: () {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return TelaInicial();

                        }), (route) => false);
              })],
            ))
          ],
        ),
    );
  }

  _axisParam(int num) {
    switch (num) {
      case 2:
        return 200.toDouble();
      case 3:
        return 180.toDouble();
      case 4:
        return 150.toDouble();
      case 5:
        return 160.toDouble();
      case 6:
        return 160.toDouble();
    }
  }

  _botaoVoltar({required String text,
    Color? corPrincipal,
    Color? corSecundaria,
    VoidCallback? onPressed}) {
    return
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  onPrimary: corSecundaria,
                  primary: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                )),
          ]
      );
  }
}
