// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/punch_model.dart';
import '../services/punch_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final punchStream = PunchService().getPunchesByUser(userId);

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Pontos')),
      body: StreamBuilder<List<Punch>>(
        stream: punchStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum registro encontrado.'));
          }

          final punches = snapshot.data!;

          return ListView.builder(
            itemCount: punches.length,
            itemBuilder: (context, index) {
              final punch = punches[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    punch.valid ? '✅ Válido' : '❌ Inválido',
                    style: TextStyle(
                      color: punch.valid ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data: ${_formatDate(punch.timestamp)}'),
                      Text('Local: ${punch.latitude.toStringAsFixed(4)}, ${punch.longitude.toStringAsFixed(4)}'),
                      if (!punch.valid)
                        const Text(
                          'Fora do raio de 100m do escritório',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),
                  trailing: Icon(
                    punch.valid ? Icons.check_circle : Icons.error,
                    color: punch.valid ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}