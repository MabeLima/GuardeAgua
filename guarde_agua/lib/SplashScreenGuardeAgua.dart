import 'package:flutter/material.dart';


class SplashScreenGuardeAgua extends StatefulWidget {
  @override
  State<SplashScreenGuardeAgua> createState() => _SplashScreanGUardeAguaState();
}

class _SplashScreanGUardeAguaState extends State<SplashScreenGuardeAgua> {
  @override
  void initState() {
    // espera 2 segundos e navega para a tela de login
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushNamed(context, '/telaLogin');
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: Image.asset('assets/images/logo2.jpeg'),
      )
    );
  }
}