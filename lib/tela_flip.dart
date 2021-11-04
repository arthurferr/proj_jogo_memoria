import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/helper/flip_card.dart';
class tela_flip extends StatelessWidget {
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
        flip_card("Imagens-Projeto/imagem_frente.jpg", "Imagens-Projeto/Derac.jpg", true),
        flip_card("Imagens-Projeto/XVdePira.png", "Imagens-Projeto/Santos.jpg", true),
        flip_card("Imagens-Projeto/IBIS.png", "Imagens-Projeto/SaoBento.jpg", true),
        flip_card("Imagens-Projeto/ADAAng.png", "Imagens-Projeto/Derac.jpg", true),
        flip_card("Imagens-Projeto/ADAAng.png", "Imagens-Projeto/Derac.jpg", true),
        flip_card("Imagens-Projeto/SaoBento.jpg", "Imagens-Projeto/casa.jpg", true),
      ],
    );
  }
}
