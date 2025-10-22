import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/favorite_movie.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final String _uid = FirebaseAuth.instance.currentUser!.uid;

  static Future<void> addFavorite(FavoriteMovie movie) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  static Future<void> removeFavorite(int movieId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(movieId.toString())
        .delete();
  }

  static Stream<QuerySnapshot> getFavoritesStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .snapshots();
  }
}