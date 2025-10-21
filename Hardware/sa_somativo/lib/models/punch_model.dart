// lib/models/punch_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Punch {
  final String id;
  final String userId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final bool valid;

  Punch({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.valid,
  });

  factory Punch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Punch(
      id: doc.id,
      userId: data['userId'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      latitude: data['latitude'],
      longitude: data['longitude'],
      valid: data['valid'],
    );
  }
}