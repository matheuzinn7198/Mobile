// lib/screens/punch_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/punch_service.dart';
import '../services/location_service.dart';

class PunchScreen extends StatefulWidget {
  const PunchScreen({super.key});

  @override
  State<PunchScreen> createState() => _PunchScreenState();
}

class _PunchScreenState extends State<PunchScreen> {
  bool _isLoading = false;
  String? _message;
  bool? _isWithinRadius;

  final PunchService _punchService = PunchService();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    bool within = await _locationService.isWithinOfficeRadius();
    if (mounted) {
      setState(() {
        _isWithinRadius = within;
      });
    }
  }

  Future<void> _registerPunch() async {
    if (_isWithinRadius != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você não está no local de trabalho!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await _punchService.registerPunch(userId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Ponto registrado com sucesso!')),
        );
        Navigator.pop(context); // volta para a Home
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isWithinRadius == true
                  ? Icons.location_on
                  : _isWithinRadius == false
                      ? Icons.location_off
                      : Icons.location_searching,
              size: 64,
              color: _isWithinRadius == true
                  ? Colors.green
                  : _isWithinRadius == false
                      ? Colors.red
                      : Colors.blue,
            ),
            const SizedBox(height: 24),
            Text(
              _isWithinRadius == null
                  ? 'Verificando localização...'
                  : _isWithinRadius!
                      ? '📍 Você está no local de trabalho!\nPronto para registrar o ponto.'
                      : '🚫 Você está fora do raio permitido (100m).',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: _isWithinRadius == true
                    ? Colors.green
                    : _isWithinRadius == false
                        ? Colors.red
                        : Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _registerPunch,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _isWithinRadius == true ? null : Colors.grey,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Registrar Ponto',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}