import 'package:flip_card/flip_card.dart';
import 'package:proj_jogo_memoria/widgets/imagens.dart';
import 'package:flutter/material.dart';


class Flip_Card extends StatefulWidget {

  String imagemFrente;
  String imagemTras;
  bool permiteTroca;


  Flip_Card(this.imagemFrente, this.imagemTras, this.permiteTroca);

  @override
  _Flip_CardState createState() => _Flip_CardState();
}

class _Flip_CardState extends State<Flip_Card> {
  GlobalKey<_Flip_CardState>cardKey = GlobalKey<_Flip_CardState>();
  @override
  Widget build(BuildContext context) {
    return FlipCard(
            key: cardKey,
            flipOnTouch: widget.permiteTroca,
        speed: 500,
        front: Container(
          child: suaImagem(caminhoImagens: widget.imagemFrente),
        ),
        back: Container(
          child: suaImagem(caminhoImagens: widget.imagemTras,)
        ),
    );



  }
}
