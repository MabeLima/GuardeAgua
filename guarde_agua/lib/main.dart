import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro2.dart';
import 'package:guarde_agua/view/cadastro/telaCadastro3.dart';
import 'package:guarde_agua/view/login/login_page2.dart';
import 'package:guarde_agua/view/recover%20account/recover_email_page.dart';
import 'package:guarde_agua/view/recover%20account/recover_password_page.dart';
import 'package:guarde_agua/view/recover%20account/recover_code_page.dart';
import 'package:guarde_agua/view/geolocation/geolocation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      initialRoute: '/telalogin',
      theme: ThemeData(fontFamily: GoogleFonts.lexend().fontFamily),
      routes: {
        '/telalogin': (context) => const LoginPage2(),
        '/telaCadastro': (context) => const TelaCadastro(),
        '/telaCadastro2': (context) => const TelaCadastro2(),
        '/telaCadastro3': (context) =>  TelaCadastro3(),
        '/telaRecuperarConta': (context) => const RecuperarConta(),
         '/verificarCodigo': (context) => const VerificarCodigo(email: '',),
        '/telaTrocarSenha': (context) => TelaTrocarSenha(email: '',),
        '/telaGeolocalizacao' : (context) => MainApp()
      },
    ),
  );
}
