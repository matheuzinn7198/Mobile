// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/biometric_auth.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nifController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  final BiometricAuth _bioAuth = BiometricAuth();

  @override
  void dispose() {
    _nifController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithCredentials() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    String nif = _nifController.text.trim();
    String password = _passwordController.text;

    User? user = await _authService.signInWithNif(nif, password);
    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIF ou senha inválidos')),
      );
    }
  }

  Future<void> _loginWithBiometrics() async {
    bool canUse = await _bioAuth.canAuthenticate();
    if (!canUse) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biometria não disponível')),
      );
      return;
    }

    bool authenticated = await _bioAuth.authenticate();
    if (authenticated) {
      // Supõe que o último usuário logado será usado
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Faça login com NIF primeiro para usar biometria')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nifController,
                decoration: const InputDecoration(labelText: 'NIF (CPF)'),
                validator: (v) => v!.length == 11 ? null : 'NIF deve ter 11 dígitos',
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (v) => v!.length >= 6 ? null : 'Senha muito curta',
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _loginWithCredentials,
                      child: const Text('Entrar com NIF'),
                    ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _loginWithBiometrics,
                icon: const Icon(Icons.fingerprint),
                label: const Text('Usar Biometria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}