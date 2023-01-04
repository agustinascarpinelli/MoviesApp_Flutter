// To parse this JSON data, do
//
//     final similarMovies = similarMoviesFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class SimilarMovies {
    SimilarMovies({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SimilarMovies.fromJson(String str) => SimilarMovies.fromMap(json.decode(str));



    factory SimilarMovies.fromMap(Map<String, dynamic> json) => SimilarMovies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}
