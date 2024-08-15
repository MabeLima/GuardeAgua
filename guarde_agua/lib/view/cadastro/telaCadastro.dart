import 'package:flutter/material.dart';

import '../../constants/app-colors.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    String tipoUsuario = '';

    void avancar() {
      Navigator.pushNamed(context, '/telaCadastro2',
          arguments: {'tipoUsuario': tipoUsuario});
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
                    
                    Text("voltar", style: TextStyle(color: AppColor.black, fontSize: 14),)
                  ],
                ));
          }),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // imagem da logo
            Center(
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Image.asset("assets/images/logo2.jpeg"),
                ),
                ),

            const SizedBox(height: 20),

            // Texto de boas-vindas
            Padding(
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
                    "Cadastre-se gratuitamente na plataforma",
                    style: TextStyle(color: AppColor.black, fontSize: 14),
                  ),
                ],
              ),
            ),

            // texto de "Sou" acima das imagens
            Row(
              children: [
                Text(
                  'Sou',
                  style: TextStyle(color: AppColor.black,fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 90),

            // alinhamento das imagens
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // botão técnico
                TextButton(
                  onPressed: () {
                    tipoUsuario = 'Técnico';
                    avancar();
                  },
                  child: Column(
                    children: [
                      // imagem técnico
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/tecnico.jpeg'),
                      ),

                      // espaçamento entre a imagem e a descrição
                      const SizedBox(height: 10),

                      // descrição da imagem
                      const Text(
                        'Técnico',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                // botão agricultor
                TextButton(
                  onPressed: () {
                    tipoUsuario = 'Agricultor';
                    avancar();
                  },
                  child: Column(
                    children: [
                      // imagem agricultor
                     Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/agricultor.jpeg'),
                      ),
                      // espaçamento entre a imagem e a descrição
                      const SizedBox(height: 10),
                      // descrição da imagem
                      const Text(
                        'Agricultor',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 120,
            ),
            Center(
                  child: TextButton(
                   onPressed: () {
                   Navigator.pop(context);
                     },
                   child: const Text(
                    'Já possui conta? Faça login',
                  style: TextStyle(
                     fontSize: 15,
                     fontWeight: FontWeight.w400,
                     color: Colors.black,
                     ),
                        ),
                      ),
                       )
          ],
        ),
      ),
    );
  }
}
