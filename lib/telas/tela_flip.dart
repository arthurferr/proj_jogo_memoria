import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/helper/flip_card.dart';
class TelaFlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela Flip"),
        backgroundColor: Colors.red,
      ) ,
       body: _flip_card(),
    );
  }

  _flip_card() {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        Flip_Card("Imagens-Projeto/imagem_frente.jpg", "Imagens-Projeto/Derac.jpg", true),
        Flip_Card("Imagens-Projeto/XVdePira.png", "Imagens-Projeto/Santos.jpg", true),
        Flip_Card("Imagens-Projeto/IBIS.png", "Imagens-Projeto/SaoBento.jpg", true),
        Flip_Card("Imagens-Projeto/ADAAng.png", "Imagens-Projeto/Derac.jpg", true),
        Flip_Card("Imagens-Projeto/ADAAng.png", "Imagens-Projeto/Derac.jpg", true),
        Flip_Card("Imagens-Projeto/SaoBento.jpg", "Imagens-Projeto/casa.jpg", true),
      ],
    );
  }
}
