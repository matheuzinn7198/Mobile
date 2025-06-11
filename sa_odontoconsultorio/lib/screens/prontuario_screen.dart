import 'package:flutter/material.dart';
import '../models/paciente_model.dart';
import '../models/atendimento_model.dart';
import '../db/db_helper.dart';
import 'atendimento_form.dart';
import 'package:intl/intl.dart';

class ProntuarioScreen extends StatefulWidget {
  final Paciente paciente;
  const ProntuarioScreen({super.key, required this.paciente});

  @override
  State<ProntuarioScreen> createState() => _ProntuarioScreenState();
}

class _ProntuarioScreenState extends State<ProntuarioScreen> {
  List<Atendimento> atendimentos = [];

  @override
  void initState() {
    super.initState();
    _carregarAtendimentos();
  }

  Future<void> _carregarAtendimentos() async {
    final lista = await DbHelper().listarAtendimentosPorPaciente(widget.paciente.id!);
    setState(() => atendimentos = lista);
  }

  void _adicionarAtendimento() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AtendimentoForm(pacienteId: widget.paciente.id!),
      ),
    );
    _carregarAtendimentos();
  }

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(title: Text("Prontuário de ${widget.paciente.nome}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Histórico Médico: ${widget.paciente.historicoMedico}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text("Atendimentos:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: atendimentos.length,
                itemBuilder: (context, index) {
                  final a = atendimentos[index];
                  return ListTile(
                    title: Text(a.descricao),
                    subtitle: Text('${f.format(a.dataHora)} - R\$ ${a.valor.toStringAsFixed(2)}'),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarAtendimento,
        child: const Icon(Icons.add),
      ),
    );
  }
}
