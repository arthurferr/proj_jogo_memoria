import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int? _numeroPares;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Memória"),
      ),
      body: _body(context),
    );
  }
// ssh-keygen -t rsa -b 4096 -C ""
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
            color: Colors.black,
          ),
        ));
  }

  /**/
  _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
            flex: 1, child: Text("Escolha o Numero de Pares de Cartas")),
        Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _button(
                  corPrincipal: Colors.green,
                    text: "2",
                    onPressed: () {
                      setState(() {
                        _numeroPares = 2;
                      });
                    }),
                _button(
                    text: "3",
                    onPressed: () {
                      setState(() {
                        _numeroPares = 3;
                      });
                    }),
                _button(
                    text: "4",
                    onPressed: () {
                      setState(() {
                        _numeroPares = 4;
                      });
                    }),
                _button(
                    text: "5",
                    onPressed: () {
                      setState(() {
                        _numeroPares = 5;
                      });
                    }),
                _button(
                    text: "6",
                    onPressed: () {
                      setState(() {
                        _numeroPares = 6;
                      });
                    }),
                _button(
                    text: "Confirmar",
                    onPressed: (_numeroPares != null) ? () {} : null)
              ],
            )),
      ],
    );
  }
}
