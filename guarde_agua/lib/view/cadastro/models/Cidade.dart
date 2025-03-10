class Cidade {
  final String id;
  final String nome;

  Cidade({required this.id, required this.nome});

  factory Cidade.fromJson(Map<String, dynamic> json){
    return Cidade(
      id: json['id'].toString(),
      nome: json['nome'],);
  }

  
}