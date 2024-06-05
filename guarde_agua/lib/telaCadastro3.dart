import 'package:flutter/material.dart';

class TelaCadastro3 extends StatefulWidget {
  const TelaCadastro3({super.key});

  @override
  State<TelaCadastro3> createState() => _TelaCadastro3State();
}

class _TelaCadastro3State extends State<TelaCadastro3> {
  @override
  Widget build(BuildContext context) {
    void avancar() {
      Navigator.pushNamed(context, '/telaLogin');
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            const SizedBox(height: 25),

            // texto "Informe o seu estado"
            const Text(
              'Informe o seu estado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento do Estado
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu estado",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto "Informe sua Cidade"
            const Text(
              'Informe sua Cidade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento da cidade
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite a cidade onde você mora",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto de "Crie sua senha"
            const Text(
              'Crie sua senha',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento da senha
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Digite sua senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto de "Confirme sua senha"
            const Text(
              'Confirme sua senha',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento da senha
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Digite novamente a sua senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 60),

            // botão de avançar
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Colors.blueAccent,
                    Colors.blueGrey,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: TextButton(
                onPressed: avancar,
                child: const Text(
                  "Avançar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
