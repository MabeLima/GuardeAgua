import 'package:flutter/material.dart';

class telaCadastro2 extends StatefulWidget {
  const telaCadastro2({super.key});

  @override
  State<telaCadastro2> createState() => _telaCadastro2State();
}

class _telaCadastro2State extends State<telaCadastro2> {
  @override
  Widget build(BuildContext context) {
    avancar(){
      Navigator.pushNamed(context, '/telaCadastro3');
    }
    return Scaffold(


    body: Column(


     children: [

          //imagem da logo
          SizedBox(
            width: 170,
            height: 170,
            child: Image.asset("assets/images/logo2.jpeg"),
          ),

          //texto abaixo da logo
          const Center(
            child: Text("Bem Vindo ao GuardeÁgua",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text("Faça seu login para entrar na plataforma",style: TextStyle(fontSize: 16),),
          ),


          const SizedBox(height: 25,),

          //texto de "Nome"
          Row(children: [
            Text('Nome',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),

          //campo de preenchimento do Nome
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu nome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),


          SizedBox(height: 15,),

          //texto "Sobrenome"
          Row(children: [
            Text('Sobrenome',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),

          //campo de preenchimento do Sobrenome
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu Sobrenome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),


          SizedBox(height: 15,),

          //texto "CPF"
            Row(children: [
            Text('CPF',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),

          //campo de preenchimento do CPF
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Digite o seu cpf",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),


          SizedBox(height: 15,),

            //texto "Email"
            Row(children: [
            Text('Email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),
            //campo de preenchimento do email
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
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

          //texto baixo do campo de email
          Container(
            alignment: Alignment.center,
            child: Text("Informe um email que você utiliza, pois ele será sua forma de login",
            style: TextStyle(fontSize:15 ),
            ),
          ),


          //botão de avançar
          SizedBox(height: 15,),
           Container(
            height: 60,
            width: 370,
            alignment: Alignment.centerLeft,

            //método usado para fazer uma variação linear nas cores do botão
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3,1],
                colors: [
                  Colors.blueAccent,
                  Colors.blueGrey
                ],),

            //deixa as bordas circulares
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            ),
            //define de fato o botão, "Sizebox.expand" faz com que o botão preencha todo o campo do container
           child: SizedBox.expand(
             child: TextButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Avançar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white ),
                  ),
                 
        ],
      ),
      //ao pressionar o botão, ele chamará a função "avancar"
            onPressed :(){
              avancar();
      },
      ),
      ),
      ),

     ]
      ),
    );
  }
}


