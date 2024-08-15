import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guarde_agua/view/cadastro/models/Cidade.dart';
import 'package:guarde_agua/view/cadastro/models/Estado.dart';
import 'package:guarde_agua/view/cadastro/models/FuncaoEstadosCidades.dart';
import 'package:http/http.dart' as http;
import 'package:guarde_agua/constants/app-colors.dart';


// biblioteca para converter tipos json em map

 class TelaCadastro3 extends StatefulWidget {
  final dropValue = ValueNotifier('');
   TelaCadastro3({super.key});

  @override
  State<TelaCadastro3> createState() => _TelaCadastro3State();
}

class _TelaCadastro3State extends State<TelaCadastro3>{
  final _formKey = GlobalKey<FormState>();

  //atributps da tela
  final dropValueEstado = ValueNotifier('');
  final dropValueCidade = ValueNotifier('');
  List<Cidade> _cidades = [];
  List<Estado> _estados = [];
  String estadoSelecionado = '';
  String cidadeSelecionada = '';
  String senha = '';
  String confirmacaoSenha = '';

  //função que atribui uma lista de estados brasileiros à variável estados
   Future<void> _carregarEstados() async {
      try{
        List<Estado> estados = await fetchEstados();
        setState(() {
          _estados = estados;
        });
      }catch(e){
        print(e);
      }
  }

  //função que atribui uma lista de cidades brasileiras à variável cidades
   Future<void> _carregarCidades(String uf) async {
    try{
      List<Cidade> cidades = await fetchCidades(uf);
      setState(() {
        _cidades = cidades;
      });
    }catch(e){
      print(e);
    }
  }

   @override
  void initState() {
    super.initState();
    _carregarEstados(); // Busca os estados no initState
    _carregarCidades('PE'); // Busca as cidades no initState
  }
  
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
      'estado': estadoSelecionado,
      'cidade': cidadeSelecionada,
      'senha': senha,
   };
    //url post de solicitação
    String apiUrl = baseUrl + "cadastrar_usuario";
  
    try {
    // Fazendo a solicitação POST para o servidor
      final response = await http.post(Uri.parse(apiUrl),body: novoUsuario,);
    // Verifica se a resposta foi bem-sucedida (código 200)
    if(response.statusCode ==200){
      avancar();
    }
    else{
      print("erro ao criar usuário");
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
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // imagem da logo
               Center(
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Image.asset("assets/images/logo2.jpeg"),        
                ),
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
                style: TextStyle(fontSize: 16,),
              ),

              // campo de preenchimento do Estado
              SizedBox(
              width: 280,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                hint: const Text('Selecione o seu estado'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                value: estadoSelecionado.isEmpty ? null : estadoSelecionado,
                onChanged: (String? escolha) {
                  setState(() {
                    estadoSelecionado = escolha!;
                    dropValueEstado.value = escolha;
                    _carregarCidades(escolha);
                    cidadeSelecionada = ''; // Resetar a cidade ao mudar o estado
                  });
                },
                items: _estados.map((Estado estado) {
                  return DropdownMenuItem<String>(
                    value: estado.sigla,
                    child: Text(estado.nome),
                  );
                }).toList(),
              ),
            ),

              const SizedBox(height: 32),

              // texto "Informe sua Cidade"
              const Text(
                'Informe sua Cidade',
                style: TextStyle(fontSize: 16),
              ),

              // campo de preenchimento da cidade
              SizedBox(
              width: 280,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                hint: const Text('Selecione a sua cidade'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                value: cidadeSelecionada.isEmpty ? null : cidadeSelecionada,
                onChanged: (escolha) {
                  setState(() {
                    cidadeSelecionada = escolha!;
                    dropValueCidade.value = escolha;
                  });
                },
                items: _cidades.map((Cidade op) {
                  return DropdownMenuItem(
                    value: op.nome,
                    child: Text(op.nome),
                  );
                }).toList(),
              ),
            ),

              const SizedBox(height: 32),

              // texto de "Crie sua senha"
              const Text(
                'Crie sua senha',
                style: TextStyle(fontSize: 16, ),
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
                    border: OutlineInputBorder(),
                    hintText: "Digite o sua senha",
                    hintStyle: TextStyle(fontSize: 12)),
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

              const SizedBox(height: 32),

              // texto de "Confirme sua senha"
              const Text(
                'Confirme sua senha',
                style: TextStyle(fontSize: 16),
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
                    border: OutlineInputBorder(),
                    hintText: "Digite novamente sua senha",
                    hintStyle: TextStyle(fontSize: 12)),
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

              const SizedBox(height: 56),

              // botão de avançar
              Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(6, 93, 124, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: TextButton(
                  onPressed: CadastrarConta,
                  child: const Text(
                    "Avançar",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
