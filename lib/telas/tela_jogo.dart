import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/helper/flip_card.dart';

class TelaJogo extends StatefulWidget {
  const TelaJogo({Key? key}) : super(key: key);

  @override
  _TelaJogoState createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: _body(),
    );
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
          )
      ),
      child: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          Flip_Card("Imagens_Projeto/Verso.jpg", "Imagens_Projeto/imagem_1.jpg",
              true),
          Flip_Card("Imagens_Projeto/Verso.jpg", "Imagens_Projeto/imagem_2.jpg",
              true),
          Flip_Card("Imagens_Projeto/Verso.jpg", "Imagens_Projeto/imagem_3.jpg",
              true),
          Flip_Card("Imagens_Projeto/Verso.jpg", "Imagens_Projeto/imagem_4.jpg",
              true),
        ],
      ),
    );
  }
}
