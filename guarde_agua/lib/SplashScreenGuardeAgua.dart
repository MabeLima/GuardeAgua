import 'package:flutter/material.dart';

class SplashScreenGuardeAgua extends StatefulWidget {
  const SplashScreenGuardeAgua({super.key});

  @override
  State<SplashScreenGuardeAgua> createState() => _SplashScreenGuardeAguaState();
}

class _SplashScreenGuardeAguaState extends State<SplashScreenGuardeAgua> {
  @override
  void initState() {
    super.initState();
    // Espera 2 segundos e navega para a tela de login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/telalogin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/embrapa.jpeg'),
      ),
    );
  }
}
