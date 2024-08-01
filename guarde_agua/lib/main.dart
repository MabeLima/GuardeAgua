import 'package:flutter/material.dart';
import 'package:guarde_agua/SplashScreenEmbrapa.dart';
import 'package:guarde_agua/SplashScreenGuardeAgua.dart';
import 'package:guarde_agua/criarNovaSenha.dart';
import 'package:guarde_agua/verificarCodigo.dart';
import 'package:guarde_agua/telaCadastro.dart';
import 'package:guarde_agua/telaCadastro2.dart';
import 'package:guarde_agua/telaCadastro3.dart';
import 'package:guarde_agua/telaLogin.dart';
import 'package:guarde_agua/telaRecuperarConta.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/splashScreenEmbrapa',
      routes: {
        '/splashScreenEmbrapa': (context) => SplashScreenEmbrapa(),
        '/splashScreenGuardeAgua': (context) => const SplashScreenGuardeAgua(),
        '/telalogin': (context) => const TelaLogin(),
        '/telaCadastro': (context) => const TelaCadastro(),
        '/telaCadastro2': (context) => const TelaCadastro2(),
        '/telaCadastro3': (context) => const TelaCadastro3(),
         '/telaRecuperarConta': (context) => const RecuperarConta(),
         '/verificarCodigo': (context) => const VerificarCodigo(email: '',),
         '/criarNovaSenha': (context) => const CriarNovaSenha(email: '',),
      },
    ),
  );
}
