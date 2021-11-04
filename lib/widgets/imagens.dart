import 'package:flutter/material.dart';

class suaImagem extends StatefulWidget {
  final String caminhoImagens;

  const suaImagem({Key? key, required this.caminhoImagens}): super(key: key);
  @override
  _suaImagemState createState() => _suaImagemState();
}

class _suaImagemState extends State<suaImagem> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.caminhoImagens,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      scale: 50,
    );
  }
}
