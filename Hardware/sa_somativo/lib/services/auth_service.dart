// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login com NIF (tratado como email único)
  Future<User?> signInWithNif(String nif, String password) async {
    try {
      // Formata NIF como email (ex: 12345678900@example.com)
      String email = '$nif@example.com';
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Erro no login: $e');
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Verifica se há usuário logado
  User? get currentUser => _auth.currentUser;
}