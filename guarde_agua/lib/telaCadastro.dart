import 'package:flutter/material.dart';


class telaCadastro extends StatelessWidget {
  const telaCadastro({super.key});

  @override
  Widget build(BuildContext context) {

    avancar(){
       Navigator.pushNamed(context, '/telaCadastro2');
    };

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
          const SizedBox(height: 40,),

          //texto de "Sou" acima das imagens
          Row(
            children: [
              Text('Sou', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ],
          ),


          SizedBox(height: 90,),


          Row(

            //alinhamento das imagens
            mainAxisAlignment: MainAxisAlignment.spaceAround,


              children: [


                //botão tecnico
                TextButton(
                  onPressed: avancar,
                  child: Column(

                      children: [
                        //imagem técnico
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/images/tecnico.jpeg'),
                        ),

                        //espaçamento entre a imagem e a descriçao
                        SizedBox(height: 10,),

                        //descrição da imagem
                        SizedBox(
                          child: Text('Técnico',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                        )
                      ],
                  ),
                ),
                
                //cria um espaçamento melhor das imagens
                SizedBox(width: 10,),

                //botão agricultor
                TextButton(
                  onPressed: avancar,
                  child: Column(

                      children: [
                        //imagem agricultor
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/images/agricultor.jpeg'),
                        ),
                        //espaçamento entre a imagem e a descrição
                        SizedBox(height: 10,),
                        // descrição da imagem
                        SizedBox(
                          child: Text('Agricultor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                        )
                      ],
                  ),
                ),
              ],
          )
          ],
        ),
    );
  }
}