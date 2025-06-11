import '../db/db_helper.dart';
import '../models/atendimento_model.dart';

class AtendimentoController {
  final DbHelper _dbHelper = DbHelper();

  Future<void> adicionarAtendimento(Atendimento atendimento) async {
    await _dbHelper.inserirAtendimento(atendimento);
  }

  Future<List<Atendimento>> listarAtendimentosDoPaciente(int pacienteId) async {
    return await _dbHelper.listarAtendimentosPorPaciente(pacienteId);
  }
}
