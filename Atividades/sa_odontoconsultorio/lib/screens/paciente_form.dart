import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sa_odontoconsultorio/models/paciente_model.dart';
import '../models/paciente_model.dart';
import '../db/db_helper.dart';

class PacienteForm extends StatefulWidget {
  const PacienteForm({super.key});

  @override
  State<PacienteForm> createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _historicoController = TextEditingController();

 void _salvarPaciente() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Converte o texto para DateTime
      DateTime nascimento = DateTime.parse(_dataController.text);
      Paciente novo = Paciente(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        dataNascimento: nascimento,
        telefone: _telefoneController.text,
        email: _emailController.text,
        historicoMedico: _historicoController.text,
      );
      await DbHelper().inserirPaciente(novo);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data de nascimento inválida! Use o formato dd-MM-yyyy')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Paciente")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nomeController, decoration: const InputDecoration(labelText: "Nome completo"), validator: (v) => v!.isEmpty ? "Informe o nome" : null),
              TextFormField(controller: _cpfController, decoration: const InputDecoration(labelText: "CPF")),
              TextFormField(controller: _dataController, decoration: const InputDecoration(labelText: "Data de nascimento (YYYY-MM-DD)"), validator: (v) => v!.isEmpty ? "Informe a data" : null),
              TextFormField(controller: _telefoneController, decoration: const InputDecoration(labelText: "Telefone")),
              TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
              TextFormField(controller: _historicoController, decoration: const InputDecoration(labelText: "Histórico médico")),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _salvarPaciente, child: const Text("Salvar"))
            ],
          ),
        ),
      ),
    );
  }
}
