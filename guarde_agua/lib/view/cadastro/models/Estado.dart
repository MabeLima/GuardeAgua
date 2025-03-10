class Estado{
  final String id;
  final String nome;
  final String sigla;

  Estado({required this.id, required this.nome, required this.sigla});

  factory Estado.fromJson(Map<String,dynamic> json){
    return Estado(
      id: json['id'].toString(),
      nome: json['nome'],
      sigla: json['sigla'],);
  }
}