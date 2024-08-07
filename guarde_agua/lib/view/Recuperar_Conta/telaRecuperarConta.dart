import 'package:flutter/material.dart';
import 'package:guarde_agua/view/Recuperar_Conta/verificarCodigo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guarde_agua/constants/app-colors.dart';

class RecuperarConta extends StatefulWidget {
  const RecuperarConta({super.key});

  @override
  State<RecuperarConta> createState() => _RecuperarContaState();
}



class _RecuperarContaState extends State<RecuperarConta> {
  String email = '';

 
 void login() {
      Navigator.pushNamed(context, '/telalogin');
    }
 
 
  final _formKey = GlobalKey<FormState>();

  Future<void> enviarRecuperacao() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var url = Uri.parse('http://192.168.0.77:3000/recuperar_senha');
        
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
          // Navegar para a tela de verificação do código
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificarCodigo(email: email)),
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
        backgroundColor: AppColor.white,
        leadingWidth: 90,
        leading: Builder(builder: (BuildContext context) {
          return TextButton(
              iconAlignment: IconAlignment.start,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 14,
                    color: AppColor.black,
                  ),
                  Text(
                    "voltar",
                    style: TextStyle(color: AppColor.black, fontSize: 14),
                  )
                ],
              ));
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: Image.asset("assets/images/logo2.jpeg"),
              ),

              const Center(
                child: Text(
                  "Bem Vindo ao GuardeÁgua",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text(
                  "Recupere sua conta",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 110),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Informe o seu e-mail cadastrado na plataforma",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                  border: OutlineInputBorder(),
                  labelText: "Digite o seu email",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
                validator: validarEmail,
              ),

              const SizedBox(height: 210),
             Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(6, 93, 124, 1),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => enviarRecuperacao(),
                  child: Text(
                    "Avançar",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Espaçamento antes do botão de login

              // Botão para tela de cadastro
              Center(
                  child: TextButton(
                  onPressed: login,
                  child: Text(
                  "Já possui conta? Faça o login",
                  style: TextStyle(color: AppColor.black ,fontSize: 16, fontWeight: FontWeight.w400),
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