import 'dart:async';
import 'dart:collection';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
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
  const TelaJogo({Key? key,
  required this.numeroPares}) : super(key: key);

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
  ];
  late List<String> _imagensSorteadas;


  List<String> _pegarListImagens(int numeroPares) {
    List<String> copia = [..._listaImagens.sublist(0, numeroPares)];
    copia.shuffle();
    List<String> imagens = [...copia];
    copia.shuffle();
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
      backgroundColor: Colors.amberAccent,
      body: _body(),
    );
  }

  _verificarImagemVirada(int indice, String imagem, bool isFrontImage,
      GlobalKey<FlipCardState> cardKey) {
    _mapController.putIfAbsent(indice, () => cardKey);

    /*bool existePar = _paresSelecionados.where((element) => element.indice1 == indice || element.indice2 == indice)
        .toList().length > 0;
    if (existePar) {
      var timer1 = Timer(Duration(milliseconds: 100), () {
        cardKey!.currentState!.toggleCard();
      });
      return;
    }*/

    if (!isFrontImage) {
      _indicesVirados.remove(indice);
      _imagensViradas.remove(indice);
      return;
    }

    if (_indicesVirados.length % 2 == 0) {
      _indicesVirados.putIfAbsent(indice, () => true);
      _imagensViradas.putIfAbsent(indice, () => imagem);
    } else {
      List<MapEntry<int, String>> entries = _imagensViradas.entries
          .where((element) => element.key != indice && element.value == imagem)
          .toList();
      if (entries.length > 0) {
        MapEntry<int, String> entry = entries[0];
        _indicesVirados.putIfAbsent(indice, () => true);
        _imagensViradas.putIfAbsent(indice, () => imagem);
        setState(() {
          _paresSelecionados.add(ParSelecionado(entry.key, indice));
        });
      } else {
        List<int> indicesParesSelecionados = [];
        if (_paresSelecionados.length > 0) {
          _paresSelecionados.forEach((element) {
            indicesParesSelecionados.add(element.indice1);
            indicesParesSelecionados.add(element.indice2);
          });
        }
        List<int> indicesRemover = [];
        _indicesVirados.entries.forEach((element) {
          if (!indicesParesSelecionados.contains(element.key)) {
            indicesRemover.add(element.key);
          }
        });
        indicesRemover.forEach((element) {
          if (_mapController.containsKey(element)) {
            _mapController[element]!.currentState!.toggleCard();
          }
          _indicesVirados.remove(element);
          _imagensViradas.remove(element);
        });

        var timer2 = Timer(Duration(milliseconds: 100), () {
          cardKey!.currentState!.toggleCard();
        });
      }
    }

    print(
        "Indices virados: ${_indicesVirados.entries.map((e) => "${e.key}").toList().join(", ")}");
    print(
        "Imagens viradas: ${_imagensViradas.entries.map((e) => "${e.value}").toList().join(", ")}");
    print(
        "Pares viradas: ${_paresSelecionados.map((e) => "${e.indice1} + ${e.indice2}").toList().join(", ")}");
  }

  _body() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightGreenAccent,
          Colors.greenAccent,
        ],
      )),
      child: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          ..._imagensSorteadas.asMap().entries.map((entry) {
            int indice = entry.key;
            String imagem = entry.value;
            bool existePar = _paresSelecionados.where((element) => element.indice1 == indice || element.indice2 == indice)
                .toList().length > 0;
            return Flip_Card("Imagens_Projeto/Verso.jpg", imagem, !existePar,
                onFlipDone: (cardState, isFrontImage) {
              _verificarImagemVirada(indice, imagem, isFrontImage, cardState);
            });
          }).toList(),
          _button(
              text: "Voltar",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TelaInicial();
                }));
              }),
          if (widget.numeroPares == _paresSelecionados.length) Text("Parabens")
        ],
      ),
    );
  }

  _button(
      {required String text,
      Color? corPrincipal,
      Color? corSecundaria,
      VoidCallback? onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          onPrimary: corSecundaria,
          primary: corPrincipal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ));
  }
}
