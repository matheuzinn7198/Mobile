// lib/services/biometric_auth.dart
import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canAuthenticate() async {
    bool canCheckBiometrics = await _auth.canCheckBiometrics;
    List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
    return canCheckBiometrics && availableBiometrics.isNotEmpty;
  }

  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Autentique para registrar seu ponto',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}