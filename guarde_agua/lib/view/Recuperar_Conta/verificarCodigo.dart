import 'package:flutter/material.dart';
import 'package:guarde_agua/view/Recuperar_Conta/tela_trocar_senha.dart'; // Importa a tela para criar nova senha
import 'package:http/http.dart' as http; // Importa a biblioteca HTTP para fazer requisições
import 'dart:convert'; // Importa a biblioteca para converter JSON
import 'dart:async'; // Importa a biblioteca para trabalhar com timers
import 'package:guarde_agua/constants/app-colors.dart';

class VerificarCodigo extends StatefulWidget {
  final String email; // Recebe o e-mail do usuário

  const VerificarCodigo({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificarCodigo> createState() => _VerificarCodigoState();
}

class _VerificarCodigoState extends State<VerificarCodigo> {
  String codigo = ''; // Código de verificação
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  late Timer _timer; // Timer para contagem regressiva
  int _remainingTime = 300; // Tempo restante em segundos (30 minutos)
  bool _canResend = false; // Flag para permitir reenvio do código

  @override
  void initState() {
    super.initState();
    _startTimer(); // Inicia o timer ao inicializar o estado
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela o timer ao descartar o widget
    super.dispose();
  }

  // Função para iniciar o timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--; // Decrementa o tempo restante
        } else {
          _canResend = true; // Permite reenvio do código após 30 minutos
          _timer.cancel(); // Cancela o timer
        }
      });
    });
  }

  // Função para mascarar o e-mail
  String mascararEmail(String email) {
    final partes = email.split('@');
    if (partes.length != 2) return email; // Retorna o e-mail original se não for válido
    final nome = partes[0];
    final dominio = partes[1];
    final nomeMascarado = nome.length > 4 
      ? nome.replaceRange(4, nome.length, '*' * (nome.length - 4)) 
      : nome;
    return '$nomeMascarado@$dominio'; // Retorna o e-mail mascarado
  }

  // Função para verificar o código
  Future<void> verificarCodigo() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        var url = Uri.parse('http://192.168.0.77:3000/verificar_codigo'); // URL da API para verificar o código
        var body = jsonEncode({'token': codigo});
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
            MaterialPageRoute(builder: (context) => TelaTrocarSenha(email: widget.email)),
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

  // Função para reenviar o código
  Future<void> reenviarCodigo() async {
    try {
      var url = Uri.parse('http://192.168.0.77:3000/recuperar_senha'); // URL da API para reenviar o código
      var body = jsonEncode({'email': widget.email});
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Código reenviado com sucesso.')),
        );
        setState(() {
          _remainingTime = 1800; // Reinicia o tempo para 30 minutos
          _canResend = false; // Desativa o botão de reenviar código
          _startTimer(); // Reinicia o timer
        });
      } else {
        var error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${error['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro na conexão com o servidor')),
      );
    }
  }

  // Função para formatar o tempo restante em minutos e segundos
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  // Função para validar o código
  String? validarCodigo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o código';
    }
    if (value.length != 5) {
      return 'O código deve ter 4 dígitos';
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

              const SizedBox(height: 30),

              const Row(children:[
                Text("Verificar o código enviado",
                 style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,)],
                  ),
         
              const SizedBox(height: 10),

              const Row(children: [
                Text("Digite o código enviado para o seu e-mail:",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,)],
                  ),

              Row(children: [
                Text(mascararEmail(widget.email),
                  style: TextStyle(fontSize: 16, 
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,)]
                  ,),
              
              const SizedBox(height: 5),

               Row(children: [
                Text(_canResend ? "Você pode reenviar o código agora." : "Reenvio do código: ${formatTime(_remainingTime)}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,)],
                  ),
              
              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Digite o código que chegou no seu email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                   border: OutlineInputBorder(),
                  labelText: "Digite o código",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: validarCodigo,
              ),


            Row(children: [Text('Não recebeu o código?',
            style: TextStyle(fontSize:16 ),),
            TextButton(
                onPressed: _canResend ? reenviarCodigo : null,
                child: 
                   Text("Reenviar código",
                style: TextStyle(
                fontSize: 16,
                color: AppColor.black,
                fontWeight: FontWeight.bold, // Define o texto como negrito
                     ),
                     ),
                  ),],
                  ),

              const SizedBox(height: 150),

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
                  onPressed: () => verificarCodigo(),
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


            ],
          ),
        ),
      ),
    );
  }
}