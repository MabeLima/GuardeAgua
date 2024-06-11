import 'package:flutter/material.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    void avancar() {
      Navigator.pushNamed(context, '/telaCadastro2');
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // imagem da logo
            SizedBox(
              width: 170,
              height: 170,
              child: Image.asset("assets/images/logo2.jpeg"),
            ),

            // texto abaixo da logo
            const Center(
              child: Text(
                "Bem Vindo ao GuardeÁgua",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "Faça seu login para entrar na plataforma",
                style: TextStyle(fontSize: 16),
              ),
            ),

            // espaçamento
            const SizedBox(height: 40),

            // texto de "Sou" acima das imagens
            Row(
              children: const [
                Text(
                  'Sou',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 90),

            // alinhamento das imagens
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // botão técnico
                TextButton(
                  onPressed: avancar,
                  child: Column(
                    children: [
                      // imagem técnico
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/tecnico.jpeg'),
                      ),

                      // espaçamento entre a imagem e a descrição
                      const SizedBox(height: 10),

                      // descrição da imagem
                      const Text(
                        'Técnico',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                // botão agricultor
                TextButton(
                  onPressed: avancar,
                  child: Column(
                    children: [
                      // imagem agricultor
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/agricultor.jpeg'),
                      ),
                      // espaçamento entre a imagem e a descrição
                      const SizedBox(height: 10),
                      // descrição da imagem
                      const Text(
                        'Agricultor',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
