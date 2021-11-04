import 'package:flutter/material.dart';
class InputTextos extends StatelessWidget {
      String rotulo;
      String label;
      TextEditingController? controller;

  InputTextos(this.rotulo, this.label, {this.controller});

  @override
  Widget build(BuildContext context) {
        return TextFormField(
        controller: controller,
        style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        backgroundColor: Colors.white
        ),

  decoration: InputDecoration(
      labelText: rotulo,
      hintText: label
      ),
      );
  }
}