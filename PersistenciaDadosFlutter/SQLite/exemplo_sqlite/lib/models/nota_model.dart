class Nota{
  //atributos = colunas BD
  final int? id?;
  final String titulo;
  final String conteudo;

  //construtor
  Nota({this.id, required this.titulo, required this.conteudo});
  
  //métoodos

  //conversão para objeto <=> BD

  // toMap Objeto => BD
  Map<String, dynamic> toMap(){
    return {
      'id': id, // id pode se nulo ao criar
      'titulo': titulo,
      'conteudo': conteudo
    };
  } 

  // fromMap BD => Objeto
  factory Nota.fromMap(Map<String, dynamic> map){
    return Nota(
      id: map["id"] as int, //converte para int(cast)
      titulo: map["titulo"] as String, 
      conteudo: map["conteudo"] as String);
  }
}