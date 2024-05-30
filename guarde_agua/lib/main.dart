import 'package:flutter/material.dart';
import 'package:flutter_application_1/SplashScreenEmbrapa.dart';
import 'package:flutter_application_1/SplashScreenGuardeAgua.dart';
import 'package:flutter_application_1/telaCadastro.dart';
import 'package:flutter_application_1/telaCadastro2.dart';
import 'package:flutter_application_1/telaCadastro3.dart';




void main() {
  runApp(
    MaterialApp(
    initialRoute: '/splashScreenEmbrapa',
    routes: {
      '/splashScreenEmbrapa' : (context) => SplashScreenEmbrapa(),
      '/splashScreenGuardeAgua' : (context) => SplashScreenGuardeAgua(),
      '/telaLogin' : (context) => tela_login(),
      '/telaCadastro': (context) => telaCadastro(),
      '/telaCadastro2' : (context) => telaCadastro2(),
      '/telaCadastro3' : (context) => Telacadastro3(),
    },
  )
  );
}

class tela_login extends StatefulWidget {
  const tela_login({super.key});

  @override
  State<tela_login> createState() => _tela_loginState();
}

class _tela_loginState extends State<tela_login> {
  //atributos de login
  String email = '';
  String senha = '';
  bool manterConectado = false;


//falta desenvolver esses métodos
  cadastrarConta(){
     Navigator.pushNamed(context, '/telaCadastro');
  }
  recuperarConta(){}
  fazerLogin(String email, String senha){
  print("O valor do email é: $email");
  print("o valor da senha é: $senha");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Column(

        children: [

          //espaçamento na tela
          const SizedBox(height: 30,),

          //imagem da logoGuardeAgua
          SizedBox(
            width: 170,
            height: 170,
            child: Image.asset("assets/images/logo2.jpeg"),
          ),

          const SizedBox(height: 25,),

          //texto abaixo da logo
          const Center(
            child: Text("Bem Vindo ao GuardeÁgua",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text("Faça seu login para entrar na plataforma",style: TextStyle(fontSize: 16),),
          ),


          const SizedBox(height: 40,),
          
          //text de "Email" acima do textformField de email
          Row(
            children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("Email",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
              ),
          ],
          ),

          //campo de preenchimento de email
          Center(
            child: TextFormField(
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
                )

              ),
            )
          ),


          const SizedBox(
            height: 25,
          ),
        //texto de "senha" acima do textformfield de senha
          Row(
            children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text("Senha",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
              ),
          ],
          ),

        //campo de preenchimento de senha
          Center(
            child: TextFormField(
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
                )

              ),
            )
          ),  

          //botão de esqueci senha
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                child: TextButton(
                   onPressed: recuperarConta, //falta desenvolver esse método
                   child: const Text("Esqueci minha senha"),
                   ),
              ),
            ],
          ),
          //checkbox de mantenha-me conectado
          //também falta desenvolver este método
          Row(
            children: [
              Checkbox(value: manterConectado, onChanged: (checked){
                setState(() {
                  manterConectado = !manterConectado;
                });
              },
              ),
              const Text("Mantenha-me conectado",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)
            ],
          ),


          const SizedBox(height: 40,),

          //botão para entrar na conta

          Container(
            height: 60,
            width: 370,
            alignment: Alignment.centerLeft,

            //método para dar uma variação linear nas cores do botão
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3,1],
                colors: [
                  Colors.blueAccent,
                  Colors.blueGrey
                ],),
            //deixa as bordas arredondadas
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            ),

          //define o botão dentro do container, "SizeBox.expad" faz com que o botão ocupe todo o espaço do container
           child: SizedBox.expand(  
             child: TextButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Entrar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white ),
                  ),
                 
        ],
      ),
            onPressed :(){
              //falta desenvolver o método de fazerLogin
              fazerLogin(email, senha);
      },
      ),
      ),
      ),

      const SizedBox(height: 5,),

      //botão para entrar na tela de cadastro
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextButton(
                   onPressed: cadastrarConta,
                   child: const Text("Não possui conta? Cadastre-se",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                   ),
              ),
            ],
          ),
      ],
      ),
      )
      ;
  }
}