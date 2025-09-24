import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late final String? uid;

  @override
  void initState() {
    super.initState();
    // Pega o UID uma vez (só funciona se o usuário já estiver logado ao entrar aqui)
    uid = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Meus Favoritos"), backgroundColor: Colors.deepPurple),
        body: const Center(child: Text("Faça login para ver seus favoritos.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Meus Favoritos"), backgroundColor: Colors.deepPurple),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid!)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhum filme favorito 😢"));
          }

          final docs = snapshot.data!.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final movie = docs[i];
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      movie['poster'] ?? '',
                      fit: BoxFit.cover,
                      height: 120,
                      errorBuilder: (c, e, s) => const Icon(Icons.movie, size: 40),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        movie['title'] ?? 'Sem título',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}