import 'package:flutter/material.dart';
import 'screens/paciente_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Odonto',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const PacienteListScreen(),
    );
  }
}
