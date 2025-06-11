import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/atendimento_model.dart';
import '../db/db_helper.dart';

class AtendimentoForm extends StatefulWidget {
  final int pacienteId;

  const AtendimentoForm({super.key, required this.pacienteId});

  @override
  State<AtendimentoForm> createState() => _AtendimentoFormState();
}

class _AtendimentoFormState extends State<AtendimentoForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _dentesController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _valorController = TextEditingController();

  DateTime? _dataSelecionada;

  void _salvarAtendimento() async {
    if (_formKey.currentState!.validate() && _dataSelecionada != null) {
      Atendimento novo = Atendimento(
        pacienteId: widget.pacienteId,
        dataHora: _dataSelecionada!,
        descricao: _descricaoController.text,
        dentesEnvolvidos: _dentesController.text,
        observacoes: _observacoesController.text,
        valor: double.parse(_valorController.text),
      );

      await DbHelper().inserirAtendimento(novo);
      Navigator.pop(context);
    }
  }

  void _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      final hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (hora != null) {
        setState(() {
          _dataSelecionada = DateTime(
              data.year, data.month, data.day, hora.hour, hora.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatador = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text("Novo Atendimento")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ElevatedButton(
                onPressed: _selecionarData,
                child: Text(_dataSelecionada == null
                    ? "Selecionar Data e Hora"
                    : "Data: ${formatador.format(_dataSelecionada!)}"),
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: "Descrição do Procedimento"),
                validator: (v) => v!.isEmpty ? "Informe a descrição" : null,
              ),
              TextFormField(
                controller: _dentesController,
                decoration: const InputDecoration(labelText: "Dentes Envolvidos"),
              ),
              TextFormField(
                controller: _observacoesController,
                decoration: const InputDecoration(labelText: "Observações"),
              ),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: "Valor Cobrado"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v!.isEmpty ? "Informe o valor" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarAtendimento,
                child: const Text("Salvar Atendimento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
