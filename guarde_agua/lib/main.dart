import 'package:flutter/material.dart';
import 'package:guarde_agua/telaCadastro.dart';
import 'package:guarde_agua/telaCadastro2.dart';
import 'package:guarde_agua/telaCadastro3.dart';
import 'package:guarde_agua/telaLogin.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/telalogin',
      routes: {
        '/telalogin': (context) => TelaLogin(),
        '/telaCadastro': (context) => TelaCadastro(),
        '/telaCadastro2': (context) => TelaCadastro2(),
        '/telaCadastro3': (context) => TelaCadastro3(),
      },
    ),
  );
}
