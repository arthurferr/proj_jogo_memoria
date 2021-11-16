import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/telas/tela_jogo.dart';

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
            fontSize: 28,
            color: Colors.white,
          ),
        ));
  }

  /**/
  _body(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightGreenAccent,
          Colors.pinkAccent,
        ],
      )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
              flex: 1,
              child: Text(
                "Escolha o Número de Pares de Cartas",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
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
                        },
                      ),
                      _button(
                          corPrincipal: Colors.green,
                          text: "3",
                          onPressed: () {
                            setState(() {
                              _numeroPares = 3;
                            });
                          }),
                      _button(
                          corPrincipal: Colors.green,
                          text: "4",
                          onPressed: () {
                            setState(() {
                              _numeroPares = 4;
                            });
                          }),
                      _button(
                          corPrincipal: Colors.green,
                          text: "5",
                          onPressed: () {
                            setState(() {
                              _numeroPares = 5;
                            });
                          }),
                      _button(
                          corPrincipal: Colors.green,
                          text: "6",
                          onPressed: () {
                            setState(() {
                              _numeroPares = 6;
                            });
                          }),
                      _button(
                          text: "Confirmar",
                          onPressed: (_numeroPares != null)
                              ? () {
                                  _abreTelaJogo(context,
                                      TelaJogo(numeroPares: _numeroPares!));
                                }
                              : null)
                    ]),
              )),
        ],
      ),
    );
  }

  _abreTelaJogo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}
