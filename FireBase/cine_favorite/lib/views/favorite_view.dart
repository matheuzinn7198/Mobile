// Tela Inicial da Aplicação – Exibe os filmes favoritos do usuário

import 'dart:io';

import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cine_favorite/views/search_movie_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  // Controlador responsável por gerenciar os filmes favoritos (CRUD no Firestore)
  final _favMovieController = FavoriteMovieController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior com título e botão de logout
      appBar: AppBar(
        title: Text("Meus Filmes Favoritos"),
        actions: [
          // Botão de logout: desloga o usuário do Firebase Authentication
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      
      // Corpo da tela: exibe a lista de filmes favoritos usando StreamBuilder
      // (atualiza automaticamente quando os dados no Firestore mudam)
      body: StreamBuilder<List<FavoriteMovie>>(
        // Obtém um Stream<List<FavoriteMovie>> diretamente do controlador
        stream: _favMovieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          // Caso ocorra um erro na leitura do Firestore
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar a lista de favoritos"),
            );
          }

          // Enquanto os dados ainda não foram carregados (conexão em andamento)
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Se a lista de favoritos estiver vazia
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("Nenhum filme adicionado aos favoritos"),
            );
          }

          // Dados carregados com sucesso: exibe os filmes em um grid
          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8), // Margem interna do grid
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 colunas no grid
              crossAxisSpacing: 8, // Espaçamento vertical entre os itens
              mainAxisSpacing: 8, // Espaçamento horizontal entre os itens
              childAspectRatio: 0.7, // Proporção largura/altura de cada item (mais alto que largo)
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];

              return Card(
                // Efeito visual de elevação e bordas arredondadas
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Imagem do pôster do filme (salva localmente no dispositivo)
                    Expanded(
                      child: Image.file(
                        File(movie.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Título do filme (centralizado abaixo da imagem)
                    Center(child: Text(movie.title)),
                    // Nota atribuída pelo usuário (pode ser expandido futuramente com estrelas ou slider)
                    Center(child: Text("Nota do Filme: ${movie.rating}")),
                  ],
                ),
              );
            },
          );
        },
      ),

      // Botão flutuante para buscar novos filmes
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchMovieView(),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}