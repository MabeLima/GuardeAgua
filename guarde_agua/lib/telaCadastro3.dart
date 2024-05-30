import 'package:flutter/material.dart';


class Telacadastro3 extends StatefulWidget {
  const Telacadastro3({super.key});

  @override
  State<Telacadastro3> createState() => _Telacadastro3State();
}

class _Telacadastro3State extends State<Telacadastro3> {
  @override
  Widget build(BuildContext context) {
     avancar(){
       Navigator.pushNamed(context, '/telaLogin');
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

          //espaçamento
          const SizedBox(height: 25,),

          //texto "Informe o seu estado"
          Row(children: [
            Text('Informe o seu estado',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),
          //campo de preenchimento do Estado
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              decoration: const InputDecoration(
                labelText: "Digite o seu estado",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),

          SizedBox(height: 15,),

          //texto "Informe sua Cidade"
          Row(children: [
            Text('Informe sua Cidade',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),
          
          //campo de preenchimento da cidade
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Digite a cidade onde você mora",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),


          SizedBox(height: 15,),

          //texto de "Crie sua senha"
            Row(children: [
            Text('Crie sua senha',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),
          //campo de preechimento da senha
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },

              //oculta a senha digitada
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

          SizedBox(height: 15,),

            //texto de "Confirme sua senha"
            Row(children: [
            Text('Confirme sua senha',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
            ),
              ],
              ),
            //campo de preenchimento da senha
          Center(
            child: TextFormField(
              onChanged: (value) {
                //preencher
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Digite novamente a sua senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )
              ),
            )
          ),
         


           //botão de avançar
          SizedBox(height: 60,),

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

            //define de fato o botão, o "SizedBox.expad" faz com que o botão ocupe todo o espaço do container
           child: SizedBox.expand(
             child: TextButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Avançar",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white ),
                  ),
                 
        ],
      ),
      //ao pressionar o botão ele irá navegar de volta para a tela incial
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