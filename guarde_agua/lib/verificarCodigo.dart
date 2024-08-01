import 'package:flutter/material.dart';
import 'package:guarde_agua/criarNovaSenha.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerificarCodigo extends StatefulWidget {
  final String email;

  const VerificarCodigo({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificarCodigo> createState() => _VerificarCodigoState();
}

class _VerificarCodigoState extends State<VerificarCodigo> {
  String codigo = '1234';

  final _formKey = GlobalKey<FormState>();

  Future<void> verificarCodigo() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var url = Uri.parse('URL_DA_API');
        var body = jsonEncode({'email': widget.email, 'token': codigo});
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          print('Verificação de código: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Código verificado com sucesso.')),
          );
          // Navegar para a tela de criar nova senha
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CriarNovaSenha(email: widget.email)),
          );
        } else {
          var error = jsonDecode(response.body);
          print('Erro na verificação de código: ${error['message']}');
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

  String? validarCodigo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o código';
    }
    if (value.length != 4) {
      return 'O código deve ter 4 dígitos';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Código'),
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
                  "Digite o código de 4 dígitos enviado para seu email",
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
                  "Código",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    codigo = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Digite o código",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: validarCodigo,
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
                  onPressed: verificarCodigo,
                  child: const Text(
                    "Verificar",
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
