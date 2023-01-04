// To parse this JSON data, do
//
//     final upcomingMovies = upcomingMoviesFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class UpcomingMovies {
    UpcomingMovies({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory UpcomingMovies.fromJson(String str) => UpcomingMovies.fromMap(json.decode(str));



    factory UpcomingMovies.fromMap(Map<String, dynamic> json) => UpcomingMovies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}
