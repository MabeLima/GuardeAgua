import 'dart:convert';
import 'package:guarde_agua/view/cadastro/models/Cidade.dart';
import 'package:guarde_agua/view/cadastro/models/Estado.dart';
import 'package:http/http.dart' as http;


Future<List<Estado>>  fetchEstados() async{
  final response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados'),
  );

  if(response.statusCode == 200){
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Estado.fromJson(json)).toList();
  }else{
    throw Exception('Erro ao caregar estados');
  }
}

Future<List<Cidade>> fetchCidades(String uf) async{

  final response = await http.get(
    Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/estados/$uf/municipios')
  );

  if(response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Cidade.fromJson(json)).toList();
  }else{
    throw Exception('Erro ao carregar cidades');
  }
}