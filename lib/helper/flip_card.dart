import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:proj_jogo_memoria/widgets/imagens.dart';
import 'package:flutter/material.dart';

class Flip_Card extends StatefulWidget {
  String imagemFrente;
  String imagemTras;
  bool permiteTroca;
  // Function(FlipCardController controller)? onFlip;
  // Function(FlipCardController controller, bool isFrontImage)? onFlipDone;
  Function(GlobalKey<FlipCardState> cardState)? onFlip;
  Function(GlobalKey<FlipCardState> cardState, bool isFrontImage)? onFlipDone;


  Flip_Card(
    this.imagemFrente,
    this.imagemTras,
    this.permiteTroca, {
    this.onFlip,
    this.onFlipDone,
  });

  @override
  _Flip_CardState createState() => _Flip_CardState();
}

class _Flip_CardState extends State<Flip_Card> {
  GlobalKey<_Flip_CardState> cardKey = GlobalKey<_Flip_CardState>();
  GlobalKey<FlipCardState> newCardKey = GlobalKey<FlipCardState>();
  FlipCardController controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: newCardKey,
      flipOnTouch: widget.permiteTroca,
      onFlipDone: widget.onFlipDone != null
          ? (isFrontImage) {
              widget.onFlipDone!(newCardKey, isFrontImage);
            }
          : null,
      speed: 500,
      front: Container(
        padding: EdgeInsets.all(3),
        child: suaImagem(caminhoImagens: widget.imagemFrente),
      ),
      back: Container(
          padding: EdgeInsets.all(3),
          child: suaImagem(
            caminhoImagens: widget.imagemTras,
          )),
    );
  }
}
