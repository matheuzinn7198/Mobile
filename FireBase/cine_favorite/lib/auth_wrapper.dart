import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/favorite_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const FavoriteView(); // logado → favoritos
        }
        return const LoginView(); // não logado → login
      },
    );
  }
}