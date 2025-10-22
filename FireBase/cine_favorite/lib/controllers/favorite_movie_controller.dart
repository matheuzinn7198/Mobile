import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_movie.dart';
import '../services/firebase_service.dart';


class FavoriteMovieController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Retorna Stream<List<FavoriteMovie>> para usar no StreamBuilder
  Stream<List<FavoriteMovie>> getFavoriteMovies() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value([]);

    final col = _db.collection('users').doc(user.uid).collection('favorites');
    return col.snapshots().map((snap) {
      return snap.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        // injeta o id do documento para operações de remoção/atualização se necessário
        data['docId'] = doc.id;
        return FavoriteMovie.fromMap(data);
      }).toList();
    });
  }

  // Adiciona favorito no Firestore (subcoleção do usuário)
  Future<void> addFavorite(FavoriteMovie movie) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'Usuário não autenticado');

    final col = _db.collection('users').doc(user.uid).collection('favorites');
    final map = movie.toMap();
    // remova campos que não devem ser salvos (ex: docId gerado pelo Firestore)
    map.remove('docId');
    map.remove('id'); // se tiver id local do filme
    await col.add(map);
  }

  // Remove favorito pelo id do documento no Firestore (docId)
  Future<void> removeFavorite(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _db.collection('users').doc(user.uid).collection('favorites').doc(docId).delete();
  }
}