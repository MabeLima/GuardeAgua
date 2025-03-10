import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:guarde_agua/constants/app-colors.dart';

class TelaTrocarSenha extends StatefulWidget {
  final String email;

  const TelaTrocarSenha({Key? key, required this.email}) : super(key: key);


  @override
  State<TelaTrocarSenha> createState() => _TelaTrocarSenhaState();
}

class _TelaTrocarSenhaState extends State<TelaTrocarSenha> {
  final _formKey = GlobalKey<FormState>();
    String novaSenha = "";
    String confirmarNovaSenha = "";

    verificarSenhas(){
      if(novaSenha == confirmarNovaSenha){
        trocarSenha();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('As senhas devem ser iguais')));
      }
    }

    Future<void> trocarSenha() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        print(widget.email);
        var url = Uri.parse('http://54.236.189.199:3000/alterar_senha');
        
        var body = jsonEncode({'email': widget.email,'senha': novaSenha});
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          print('Recuperação de senha: $responseData');
          print('Senha alterada!!!!!!!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Senha trocada com sucesso!')),
          );
          // Navegar para a tela de verificação do código
          print("Olá Mundo!!!");
          Navigator.pushNamed(context, '/telalogin');
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

  @override
  Widget build(BuildContext context) {

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
                    
                    Text("voltar", style: TextStyle(color: AppColor.black, fontSize: 14),)
                  ],
                ));
          }),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: Image.asset('assets/images/logo2.jpeg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                           top: 24, bottom: 56),
                      child: Column(
                        children: [
                          Text(
                            "Bem vindo ao GuardeÁgua",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text("Recupere a sua senha",
                              style: TextStyle(
                                  color: AppColor.black, fontSize: 14)),
                        ],
                      ),
                    ),
                    Text(
                        "Para sua segurança no sistema é obrigatório redefinir sua senha de acesso no sistema. ",
                        style: TextStyle(color: AppColor.black, fontSize: 14)),
                    const SizedBox(
                      height: 56,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Crie um nova senha",
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Digite sua senha",
                                hintStyle: TextStyle(fontSize: 12)
                              ),
                              onChanged: (value) {
                                setState(() {
                                  novaSenha = value;
                                });
                              },
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
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              "Confirme sua senha",
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Digite novamente sua senha",
                                hintStyle: TextStyle(fontSize: 12)
                              ),
                              onChanged: (value) {
                                setState(() {
                                  confirmarNovaSenha = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira a sua senha';
                                }
                                if (value != novaSenha) {
                                  return 'As senhas não coincidem';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 56,),
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
                  onPressed: () {
                     verificarSenhas();
                  },
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
        )
        );
  }
}
