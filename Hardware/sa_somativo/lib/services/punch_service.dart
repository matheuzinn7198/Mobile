// lib/services/punch_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../models/punch_model.dart'; // ← não esqueça de importar o modelo!
import 'location_service.dart';

class PunchService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método existente: registrar ponto
  Future<void> registerPunch(String userId) async {
    final now = DateTime.now();
    final position = await Geolocator.getCurrentPosition();
    final valid = await LocationService().isWithinOfficeRadius();

    await _db.collection('punches').add({
      'userId': userId,
      'timestamp': now,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'valid': valid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 🔽 NOVO MÉTODO: buscar histórico do usuário
  Stream<List<Punch>> getPunchesByUser(String userId) {
    return _db
        .collection('punches')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Punch.fromFirestore(doc)).toList());
  }
}