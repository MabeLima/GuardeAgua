import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants/app-colors.dart';

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

  final _formKey = GlobalKey<FormState>();

  // Métodos
  void cadastrarConta() {
    Navigator.pushNamed(context, '/telaCadastro');
  }

  void recuperarConta() {
    Navigator.pushNamed(context, '/telaTrocarSenha');
    // Implementar recuperação de conta
  }

  void fazerLogin(String email, String senha) async {
    if (_formKey.currentState?.validate() ?? false) {
      const Url = "http://192.168.0.77:3000/login";

      Map<String, String> usuario = {'email': email, 'senha': senha};
      try {
        final response = await http.post(Uri.parse(Url), body: usuario);

        if (response.statusCode == 200) {
          print('Usuário presente no banco de dados');
        } else {
          // Se a resposta não foi bem-sucedida, exibe uma mensagem de erro
          print(
              "Falha ao fazer fazer login. Código de status: ${response.statusCode}");
        }
      } catch (e) {
        print('erro ao fazer login $e');
      }
      // Aqui você chamaria o método que faz o login no backend
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email';
    }
    // Expressão regular para validar email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),

              // Imagem da logo
              SizedBox(
                width: 140,
                height: 140,
                child: Image.asset("assets/images/logo2.jpeg"),
              ),

              const SizedBox(height: 25),

              // Texto de boas-vindas
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 80),
                child: Column(
                  children: [
                    Text(
                      "Bem vindo ao GuardeÁgua",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Faça seu login para entrar na plataforma",
                      style: TextStyle(color: AppColor.black, fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Campo de email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu email",
                  hintStyle: TextStyle(fontSize: 12)
                ),
             
                validator: validarEmail,
              ),

              const SizedBox(height: 25),

              // Campo de senha
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Senha",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
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
                  border: OutlineInputBorder(),
                  hintText: "Digite sua senha",
                  hintStyle: TextStyle(fontSize: 12)
                ),
               
                validator: validarSenha,
              ),

              // Botão de "esqueci a senha"
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: recuperarConta,
                    child: Text("Esqueci minha senha", style: TextStyle(color: AppColor.black, fontSize: 12, fontWeight: FontWeight.w100),),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              const SizedBox(height: 56),

              // Botão de login
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => fazerLogin(email, senha),
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),

              // const SizedBox(height: 2),

              // Botão para tela de cadastro
              Center(
                child: TextButton(
                  onPressed: cadastrarConta,
                  child: Text(
                    "Não possui conta? Cadastre-se",
                    style: TextStyle(color: AppColor.black,fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
