  import 'package:flutter/material.dart';
  import 'tela_inicial.dart';

void main(){
    runApp(MaterialApp(
      title: "Exemplo de Shared Preferences",
      home: TelaInicial(),
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
    ));
  }