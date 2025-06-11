class Paciente{
  int? id;
  String nome;
  String cpf;
  DateTime dataNascimento;
  String telefone;
  String email;
  String historicoMedico;

  Paciente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.telefone,
    required this.email,
    required this.historicoMedico
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "nome": nome,
      "cpf": cpf,
      "dataNascimento": dataNascimento.toIso8601String(), //para converter o obj para data(DateTime) em uma String
      "telefone": telefone,
      "email": email,
      "historicoMedico": historicoMedico
    };
  }

  factory Paciente.fromMap(Map<String, dynamic> map){
    return Paciente(
      id: map ["id"],
      nome: map ["nome"], 
      cpf: map ["cpf"], 
      dataNascimento: DateTime.parse(map ["dataNascimeto"]), 
      telefone: map ["telefone"], 
      email: map ["email"], 
      historicoMedico: map ["historicoMedico"]
      );
  }
}