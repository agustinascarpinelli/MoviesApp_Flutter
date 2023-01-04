// To parse this JSON data, do
//
//     final searchMovie = searchMovieFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class SearchMovie {
    SearchMovie({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SearchMovie.fromJson(String str) => SearchMovie.fromMap(json.decode(str));

  

    factory SearchMovie.fromMap(Map<String, dynamic> json) => SearchMovie(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

 
}
