import 'dart:convert';

class Movie {
    Movie({
        this.backdropPath,
       required this.adult,
       required this.genreIds,
       required this.id,
       required this.originalLanguage,
       required this.originalTitle,
       required this.overview,
       required this.popularity,
      //Opcionales, no todas lo tienen.
      this.posterPath,
      this.releaseDate,
       required this.title,
       required this.video,
       required this.voteAverage,
       required this.voteCount,
    });

    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String ?posterPath;
    //Cambio el realeaseDate de Date to String, para no tener que parsearlo despues
   String? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;
    //id para utilizar el hero id (ya que necesito un id unico para algunas peliculas que estan tanto en el cars swiper como en el movie slider, la animacion no funciona porque tienen el mismo id.)
    String? heroAnimationId;

    

//creo el url para las imagenes
get fullPosterImg{
  if(this.posterPath!=null){
     return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
  }
 
  else{
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}

get fullBackbrogPath{
  if(this.backdropPath!=null){
     return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
  }
 
  else{
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}




//Tengo que importar la libreria Dart:convert
    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

//Recibe un mapa que se llama json y esta tomando cada una de sus propiedades (instancias) y se las asigna a propiedades de la clase
    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage:json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate:json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );


}



