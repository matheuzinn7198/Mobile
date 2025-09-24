//classe de modelagem de dados para Models

class FavoriteMovie {
  //atributos
  final int id; //Id fo TMDB
  final String title; //titulo do filme no TMDB
  final String posterPath; //Caminho apra imagem do Poster
  double rating; //nota que o Usuário do APP dará para o filme

  //constructor
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0
  });

  //métodos de conversão de OBJ <=> Json

  //toMap
  Map<String,dynamic> toMap(){
    return{
      "id": id,
      "title":title,
      "postePath":posterPath,
      "rating":rating
    };
  }

  //fromMap
  factory FavoriteMovie.fromMap(Map<String,dynamic> map){
    return FavoriteMovie(
      id: map["id"], 
      title: map["title"], 
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble());
  }
}