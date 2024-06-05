import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Atributos de login
  String email = '';
  String senha = '';
  bool manterConectado = false;

  // Métodos
  void cadastrarConta() {
    Navigator.pushNamed(context, '/telaCadastro');
  }

  void recuperarConta() {
    // Implementar recuperação de conta
  }

  void fazerLogin(String email, String senha) {
    print("O valor do email é: $email");
    print("O valor da senha é: $senha");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),

            // Imagem da logo
            SizedBox(
              width: 170,
              height: 170,
              child: Image.asset("assets/images/logo2.jpeg"),
            ),

            const SizedBox(height: 25),

            // Texto de boas-vindas
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

            const SizedBox(height: 40),

            // Campo de email
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
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

            const SizedBox(height: 25),

            // Campo de senha
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Senha",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  senha = value;
                });
              },
              keyboardType: TextInputType.text,
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

            // Botão de "esqueci a senha"
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: recuperarConta,
                  child: const Text("Esqueci minha senha"),
                ),
              ],
            ),

            // Checkbox de manter conectado
            Row(
              children: [
                Checkbox(
                  value: manterConectado,
                  onChanged: (checked) {
                    setState(() {
                      manterConectado = checked ?? false;
                    });
                  },
                ),
                const Text(
                  "Mantenha-me conectado",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Botão de login
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
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () => fazerLogin(email, senha),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Botão para tela de cadastro
            Center(
              child: TextButton(
                onPressed: cadastrarConta,
                child: const Text(
                  "Não possui conta? Cadastre-se",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
