import 'package:flip_card/flip_card.dart';
import 'package:proj_jogo_memoria/widgets/imagens.dart';
import 'package:flutter/material.dart';


class flip_card extends StatefulWidget {

  String imagemFrente;
  String imagemTras;
  bool permiteTroca;


  flip_card(this.imagemFrente, this.imagemTras, this.permiteTroca);

  @override
  _flip_cardState createState() => _flip_cardState();
}

class _flip_cardState extends State<flip_card> {
  GlobalKey<_flip_cardState>cardKey = GlobalKey<_flip_cardState>();
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
