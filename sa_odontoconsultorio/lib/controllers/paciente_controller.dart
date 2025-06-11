import '../db/db_helper.dart';
import '../models/paciente_model.dart';

class PacienteController {
  final DbHelper _dbHelper = DbHelper();

  Future<List<Paciente>> getPacientes() async {
    return await _dbHelper.listarPacientes();
  }

  Future<void> adicionarPaciente(Paciente paciente) async {
    await _dbHelper.inserirPaciente(paciente);
  }

  Future<void> atualizarPaciente(Paciente paciente) async {
    await _dbHelper.atualizarPaciente(paciente);
  }

  Future<void> excluirPaciente(int id) async {
    await _dbHelper.excluirPaciente(id);
  }
}
