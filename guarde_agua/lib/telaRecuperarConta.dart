import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecuperarConta extends StatefulWidget {
  const RecuperarConta({super.key});

  @override
  State<RecuperarConta> createState() => _RecuperarContaState();
}

class _RecuperarContaState extends State<RecuperarConta> {
  String email = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> enviarRecuperacao() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var url = Uri.parse('');
        var body = jsonEncode({'email': email});
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          print('Recuperação de senha: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Um email de recuperação foi enviado.')),
          );
        } else {
          var error = jsonDecode(response.body);
          print('Erro na recuperação de senha: ${error['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: ${error['message']}')),
          );
        }
      } catch (e) {
        print('Erro na requisição: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro na conexão com o servidor')),
        );
      }
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),

              // Texto de instrução
              const Center(
                child: Text(
                  "Digite seu email para recuperar sua conta",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 170,
                height: 170,
                child: Image.asset("assets/images/logo2.jpeg"),
              ),

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
                validator: validarEmail,
              ),

              const SizedBox(height: 40),

              // Botão de enviar
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
                  onPressed: enviarRecuperacao,
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
