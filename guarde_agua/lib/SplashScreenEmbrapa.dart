import 'package:flutter/material.dart';


class SplashScreenEmbrapa extends StatefulWidget {
  @override
  _SplashScreenEmbrapa createState() => _SplashScreenEmbrapa();
}

class _SplashScreenEmbrapa extends State<SplashScreenEmbrapa> {
  @override
  void initState() {
    super.initState();
    // Espera 2 segundo e navega para a próxima tela e  navega para a SplashScreenGuardeAgua
      Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/splashScreenGuardeAgua');
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
