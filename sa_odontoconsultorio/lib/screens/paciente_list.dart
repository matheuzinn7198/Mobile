import 'package:flutter/material.dart';
import '../models/paciente_model.dart';
import '../db/db_helper.dart';
import 'paciente_form.dart';
import 'prontuario_screen.dart';

class PacienteListScreen extends StatefulWidget {
  const PacienteListScreen({super.key});

  @override
  State<PacienteListScreen> createState() => _PacienteListScreenState();
}

class _PacienteListScreenState extends State<PacienteListScreen> {
  List<Paciente> pacientes = [];

  @override
  void initState() {
    super.initState();
    _carregarPacientes();
  }

  Future<void> _carregarPacientes() async {
    final lista = await DbHelper().listarPacientes();
    setState(() => pacientes = lista);
  }

  void _navegarParaFormulario() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => const PacienteForm()));
    _carregarPacientes();
  }

  void _abrirProntuario(Paciente paciente) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ProntuarioScreen(paciente: paciente)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pacientes')),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          final p = pacientes[index];
          return ListTile(
            title: Text(p.nome),
            subtitle: Text(p.telefone),
            onTap: () => _abrirProntuario(p),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaFormulario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
