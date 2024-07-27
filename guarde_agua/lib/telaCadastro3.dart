import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// biblioteca para converter tipos json em map

class TelaCadastro3 extends StatefulWidget {
  const TelaCadastro3({super.key});

  @override
  State<TelaCadastro3> createState() => _TelaCadastro3State();
}

class _TelaCadastro3State extends State<TelaCadastro3> {
  final _formKey = GlobalKey<FormState>();

  //atributps da tela
  String estado = '';
  String cidade = '';
  String senha = '';
  String confirmacaoSenha = '';

  @override
  Widget build(BuildContext context) {

    //base da url do servidor
   const baseUrl = "http://192.168.0.77:3000/";

  //recebimento dos parametros passados para uma variável "data" do tipo Map
   Map? data = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    void avancar() {
      if (_formKey.currentState?.validate() ?? false) {
        Navigator.pushNamed(context, '/telalogin');
      }
    }

     //função que solicita ao servidor o cadastramento de um usuário
   CadastrarConta() async{
    //contrução do usuário
    if(_formKey.currentState!.validate()){
      Map <String,String> novoUsuario = {
      'tipoUsuario': data?['tipoUsuario'],
      'nome': data?['nome'],
      'sobrenome': data?['sobrenome'],
      'cpf': data?['cpf'],
      'email': data?['email'],
      'estado': estado,
      'cidade': cidade,
      'senha': senha,
   };
    //url post de solicitação
    String apiUrl = baseUrl + "cadastrar_usuario";
  
    try {
    // Fazendo a solicitação POST para o servidor
      final response = await http.post(
      Uri.parse(apiUrl),
      body: novoUsuario,
  
    );

    // Verifica se a resposta foi bem-sucedida (código 200)
    if (response.statusCode == 200) {
      avancar();
    } else {
      // Se a resposta não foi bem-sucedida, exibe uma mensagem de erro
      print("Falha ao fazer cadastro. Código de status: ${response.statusCode}");
    }
  } catch (e) {
    // Se ocorrer um erro durante a solicitação, exibe o erro
      print("Erro ao fazer cadastro: $e");

  }   
    } 
    else(){
      print('Form inválido');
    };
   }


    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
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
                  setState(() {
                    estado = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Digite o seu estado",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu estado';
                  }
                  return null;
                },
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
                  setState(() {
                    cidade = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Digite a cidade onde você mora",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sua cidade';
                  }
                  return null;
                },
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
                  setState(() {
                    senha = value;
                  });
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sua senha';
                  }
                  if (value.length < 8) {
                    return 'A senha deve ter pelo menos 8 caracteres';
                  }
                  return null;
                },
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
                  setState(() {
                    confirmacaoSenha = value;
                  });
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, confirme a sua senha';
                  }
                  if (value != senha) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
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
                  onPressed: CadastrarConta,
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
      ),
    );
  }
}
