import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarde_agua/telaCadastro.dart';
import 'package:guarde_agua/telaCadastro2.dart';
import 'package:guarde_agua/telaCadastro3.dart';
import 'package:guarde_agua/telaLogin.dart';
import 'package:guarde_agua/view/tela_trocar_senha.dart';

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
        '/telaCadastro3': (context) => const TelaCadastro3(),
        '/telaTrocarSenha': (context) => TelaTrocarSenha(),
      },
    ),
  );
}
