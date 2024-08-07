import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro2.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro3.dart';
import 'package:guarde_agua/view/login/telaLogin.dart';
import 'package:guarde_agua/view/Recuperar_Conta/telaRecuperarConta.dart';
import 'package:guarde_agua/view/Recuperar_Conta/tela_trocar_senha.dart';
import 'package:guarde_agua/view/Recuperar_Conta/verificarCodigo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: '/telalogin',
      theme: ThemeData(fontFamily: GoogleFonts.lexend().fontFamily),
      routes: {
        '/telalogin': (context) => const TelaLogin(),
        '/telaCadastro': (context) => const TelaCadastro(),
        '/telaCadastro2': (context) => const TelaCadastro2(),
        '/telaCadastro3': (context) =>  TelaCadastro3(),
        '/telaRecuperarConta': (context) => const RecuperarConta(),
         '/verificarCodigo': (context) => const VerificarCodigo(email: '',),
        '/telaTrocarSenha': (context) => TelaTrocarSenha(email: '',),
      },
    ),
  );
}
