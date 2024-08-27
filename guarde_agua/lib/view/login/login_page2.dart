import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:guarde_agua/constants/app-colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';



class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();    
}

class _LoginPage2State extends State<LoginPage2> {
  // Atributos de login
  Position? _initPositionGeo;
  LatLng? _initialPosition;
  final _storage = const FlutterSecureStorage();
  final TextEditingController _email = TextEditingController(text:"");
  final TextEditingController _senha = TextEditingController(text:"");
  bool manterConectado = false;
  final _formKey = GlobalKey<FormState>();

  // Métodos
 void _setInitialPosition() async {
    _initPositionGeo = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    if (mounted) {
      setState(() {
        _initialPosition =
            LatLng(_initPositionGeo!.latitude, _initPositionGeo!.longitude);
      });
    }
  }

  void _solicitarPermissao() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('Permissão de localização negada');
    } else if (permission == LocationPermission.deniedForever) {
      print('Permissão negada permanentemente');
    } else {
      _setInitialPosition();
    }
  }

  //método que grava os dados caso o usuário selecione o checkbox "mantenha-me conectado"
  void gravarDados() async {
      if(_formKey.currentState?.validate() ?? false){
        if(manterConectado){
          await _storage.write(key: "email", value: _email.text);
          print(_storage.read(key:'email'));
          await _storage.write(key:"senha",value: _senha.text);
          print(_storage.read(key:'senha'));
        }
        else{
          await _storage.write(key:'email', value :"");
          await _storage.write(key: 'senha',value:"");
        }
      }
  }

// método que lê os dados caso o usuário tenha selecionado o checkbox "mantenha-me conectado" 
  Future<void> _lerDados() async {
    _email.text = await _storage.read(key: "email") ?? '';
    print('seu email é:' + _email.text);
    _senha.text = await _storage.read(key: "senha") ?? '';
    print('sua senha é:' + _senha.text);
  }

  void cadastrarConta() {
    Navigator.pushNamed(context, '/telaCadastro');
  }

  void recuperarConta(){
    Navigator.pushNamed(context, '/telaRecuperarConta');
  }

  void fazerLogin(String email, String senha) async {
    if (_formKey.currentState?.validate() ?? false) {
      const Url = "http://54.236.189.199:3000/login";


      Map<String,String> usuario = {
        'email': email,
        'senha': senha
     };

    try{
      final response = await http.post( Uri.parse(Url),body:usuario );

      if (response.statusCode == 200) {
        print('Usuário presente no banco de dados');
        gravarDados();
        Navigator.pushNamed(context, '/telaGeolocalizacao',arguments: _initialPosition);
    } else {
      // Se a resposta não foi bem-sucedida, exibe uma mensagem de erro
      print("Falha ao fazer fazer login. Código de status: ${response.statusCode}");
    }
    }catch(e){
      print('erro ao fazer login $e');
    }
      // Aqui você chamaria o método que faz o login no backend
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email';
    }
    // Expressão regular para validar email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _lerDados();
    _solicitarPermissao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),

              // Imagem da logo
              SizedBox(
                width: 140,
                height: 140,
                child: Image.asset("assets/images/logo2.jpeg"),
              ),

              const SizedBox(height: 25),

              // Texto de boas-vindas
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 80),
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
                      "Faça seu login para entrar na plataforma",
                      style: TextStyle(color: AppColor.black, fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Campo de email
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _email,
                onChanged: (value) {
                  setState(() {
                    _email.text = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu email",
                  hintStyle: TextStyle(fontSize: 12)
                ),
             
                validator: validarEmail,
              ),

              const SizedBox(height: 25),

              // Campo de senha
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Senha",
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _senha,
                onChanged: (value) {
                  setState(() {
                    _senha.text = value;
                  });
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite sua senha",
                  hintStyle: TextStyle(fontSize: 12)
                ),
               
                validator: validarSenha,
              ),

              // Botão de "esqueci a senha"
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: recuperarConta,
                    child: Text("Esqueci minha senha", style: TextStyle(color: AppColor.black, fontSize: 12, fontWeight: FontWeight.w100),),
                  ),
                ],
              ),

              // Checkbox de manter conectado
              Row(
                children: [
                  Checkbox(
                    value: manterConectado,
                    onChanged: (checked) {
                      setState(() {
                        manterConectado = checked ?? false;
                        print(manterConectado);
                      });
                    },
                  ),
                  const Text(
                    "Mantenha-me conectado",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),

              const SizedBox(height: 56),

              // Botão de login
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
                  onPressed: () =>  Navigator.pushNamed(context, '/telaGeolocalizacao',arguments: _initialPosition),
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),

              // const SizedBox(height: 2),

              // Botão para tela de cadastro
              Center(
                child: TextButton(
                  onPressed: cadastrarConta,
                  child: Text(
                    "Não possui conta? Cadastre-se",
                    style: TextStyle(color: AppColor.black,fontSize: 16, fontWeight: FontWeight.w400),
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
