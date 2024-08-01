import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importação necessária
import 'dart:convert'; // Importar para o uso de jsonEncode e jsonDecode

class CriarNovaSenha extends StatefulWidget {
  final String email;

  const CriarNovaSenha({Key? key, required this.email}) : super(key: key);

  @override
  State<CriarNovaSenha> createState() => _CriarNovaSenhaState();
}

class _CriarNovaSenhaState extends State<CriarNovaSenha> {
  String novaSenha = '';
  String confirmarSenha = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> criarNovaSenha() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var url = Uri.parse('URL_DA_API'); // Substitua pela URL correta
        var body = jsonEncode({'email': widget.email, 'password': novaSenha});
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          print('Criação de nova senha: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Senha alterada com sucesso.')),
          );
          // Navegar para a tela de login ou outra tela
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          var error = jsonDecode(response.body);
          print('Erro na criação de nova senha: ${error['message']}');
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

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? confirmarSenhaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha';
    }
    if (value != novaSenha) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Nova Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "Crie uma nova senha",
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nova Senha",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    novaSenha = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Digite a nova senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: validarSenha,
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirmar Senha",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    confirmarSenha = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirme a nova senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: confirmarSenhaValidator,
              ),
              const SizedBox(height: 40),
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
                  onPressed: criarNovaSenha,
                  child: const Text(
                    "Salvar",
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
