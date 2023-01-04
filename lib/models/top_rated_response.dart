// To parse this JSON data, do
//
//     final topRated = topRatedFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_app/models/models.dart';

class TopRated {
    TopRated({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory TopRated.fromJson(String str) => TopRated.fromMap(json.decode(str));

 

    factory TopRated.fromMap(Map<String, dynamic> json) => TopRated(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}

