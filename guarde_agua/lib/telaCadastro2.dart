import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart'; // Biblioteca para validação de CPF
import 'package:flutter/services.dart';

import 'constants/app-colors.dart';

class TelaCadastro2 extends StatefulWidget {
  const TelaCadastro2({super.key});

  @override
  State<TelaCadastro2> createState() => _TelaCadastro2State();
}

class _TelaCadastro2State extends State<TelaCadastro2> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String sobrenome = '';
  String cpf = '';
  String email = '';
  String usuario = '';

  bool validarCPF(String cpf) {
    return UtilBrasilFields.isCPFValido(cpf);
  }

  @override
  Widget build(BuildContext context) {
    //O operador de negação ! em Dart é usado para forçar uma expressão que pode ser null a não ser null.
    //No contexto de Flutter, o operador ! é usado frequentemente para acessar propriedades que podem ser nulas,
    //mas que você sabe (ou espera) que não sejam nulas em tempo de execução.
    Map? tipoUsuario =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    usuario = tipoUsuario['tipoUsuario'];
    //função avançar passando os parametros para a próxima tela

    void avancar() {
      if (_formKey.currentState?.validate() ?? false) {
        Navigator.pushNamed(context, '/telaCadastro3', arguments: {
          'nome': nome,
          'sobrenome': sobrenome,
          'cpf': cpf,
          'email': email,
          'tipoUsuario': usuario
        });
      } else {
        print('Form inválido');
      }
    }

    return Scaffold(
      backgroundColor: AppColor.white,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: // imagem da logo
                    SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset("assets/images/logo2.jpeg"),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: EdgeInsets.only( bottom: 32),
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
                        "Cadastrar técnico",
                        style: TextStyle(color: AppColor.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              // Texto de boas-vindas

              const SizedBox(height: 25),

              // texto de "Nome"
              const Text(
                'Nome',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // campo de preenchimento do Nome
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    nome = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Digite o seu nome",
                    hintStyle: TextStyle(fontSize: 12)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu nome';
                  } else if (value.length < 2) {
                    return ('Insira um nome válido');
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // texto "Sobrenome"
              const Text(
                'Sobrenome',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // campo de preenchimento do Sobrenome
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    sobrenome = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Digite o seu sobrenome",
                    hintStyle: TextStyle(fontSize: 12)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu sobrenome';
                  } else if (value.length < 2) {
                    return ('Sobrenome inválido');
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // texto "CPF"
              const Text(
                'CPF',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // campo de preenchimento do CPF
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    cpf = value;
                  });
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Digite o seu CPF",
                    hintStyle: TextStyle(fontSize: 12)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu CPF';
                  } else if (!validarCPF(value)) {
                    return 'Por favor, insira um CPF válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 32),

              // texto "Email"
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // campo de preenchimento do email
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Digite o seu email",
                    hintStyle: TextStyle(fontSize: 12)),
                validator: (value) {
                  String pattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu email';
                  }
                  if (!regex.hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 4),

              // texto abaixo do campo de email
              Text(
                "Informe um email que você utiliza, pois ele será sua forma de login",
                style: TextStyle(color: AppColor.black, fontSize: 12),
              ),

              const SizedBox(height: 56),

              // botão de avançar
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: TextButton(
                  onPressed: avancar,
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
