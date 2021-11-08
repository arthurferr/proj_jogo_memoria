import 'package:flutter/material.dart';
import 'package:proj_jogo_memoria/telas/tela_inicial.dart';
import 'package:proj_jogo_memoria/telas/tela_jogo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaJogo(),
    );
  }
}
