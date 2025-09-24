class Atendimento{
  int? id;
  int pacienteId;
  DateTime dataHora;
  String descricao;
  String dentesEnvolvidos;
  String observacoes;
  double valor;

  Atendimento({
    this.id,
    required this.pacienteId,
    required this.dataHora,
    required this.descricao,
    required this.dentesEnvolvidos,
    required this.observacoes,
    required this.valor
  });

Map<String, dynamic> toMap(){
  return {
    "id": id,
    "pacienteId": pacienteId,
    "dataHora": dataHora.toIso8601String(),
    "descricao":descricao,
    "dentesEnvolvidos": dentesEnvolvidos,
    "observacoes":observacoes,
    "valor": valor
  };
}

factory Atendimento.fromMap(Map<String, dynamic> map) {
    return Atendimento(
      id: map['id'],
      pacienteId: map['pacienteId'],
      dataHora: DateTime.parse(map['dataHora']),
      descricao: map['descricao'],
      dentesEnvolvidos: map['dentesEnvolvidos'],
      observacoes: map['observacoes'],
      valor: map['valor'],
    );
  }
}