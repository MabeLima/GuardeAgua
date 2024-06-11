import 'package:flutter/material.dart';
import 'package:guarde_agua/SplashScreenEmbrapa.dart';
import 'package:guarde_agua/SplashScreenGuardeAgua.dart';
import 'package:guarde_agua/features/cadastro/presentation/pages/telaCadastro.dart';
import 'package:guarde_agua/features/cadastro/presentation/pages/telaCadastro2.dart';
import 'package:guarde_agua/features/cadastro/presentation/pages/telaCadastro3.dart';
import 'package:guarde_agua/features/login/presentation/pages/telaLogin.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/splashScreenEmbrapa',
      routes: {
        '/splashScreenEmbrapa': (context) => SplashScreenEmbrapa(),
        '/splashScreenGuardeAgua': (context) => SplashScreenGuardeAgua(),
        '/telalogin': (context) => TelaLogin(),
        '/telaCadastro': (context) => TelaCadastro(),
        '/telaCadastro2': (context) => TelaCadastro2(),
        '/telaCadastro3': (context) => TelaCadastro3(),
      },
    ),
  );
}
