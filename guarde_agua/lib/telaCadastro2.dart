import 'package:flutter/material.dart';

class TelaCadastro2 extends StatefulWidget {
  const TelaCadastro2({super.key});

  @override
  State<TelaCadastro2> createState() => _TelaCadastro2State();
}

class _TelaCadastro2State extends State<TelaCadastro2> {
  @override
  Widget build(BuildContext context) {
    void avancar() {
      Navigator.pushNamed(context, '/telaCadastro3');
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

            // texto de "Nome"
            const Text(
              'Nome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento do Nome
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu nome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto "Sobrenome"
            const Text(
              'Sobrenome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento do Sobrenome
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu Sobrenome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto "CPF"
            const Text(
              'CPF',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento do CPF
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Digite o seu CPF",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto "Email"
            const Text(
              'Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),

            // campo de preenchimento do email
            TextFormField(
              onChanged: (value) {
                //preencher
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Digite o seu email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // texto abaixo do campo de email
            const Text(
              "Informe um email que você utiliza, pois ele será sua forma de login",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 25),

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
