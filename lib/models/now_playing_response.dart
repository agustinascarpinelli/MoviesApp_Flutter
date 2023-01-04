//Los models son clases que sirven para mapear una respuesta de una peticion
//Utilizamos quicktype.io. Nos ayuda a crear una clase que se adapte a un json en especifico. (copiamos la respuesta de postman, la pegamos en el QuickType. Le cambiamos el nombre a la clase, seleccionamos DART,le agregamos que utilice encoder y decoder y los metodos toMap y fromMap)

// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';





class NowPlayingResponse {
    NowPlayingResponse({
      //argumentos que esta esperando recibir.Le agregamos el required porque son obligatorios.
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });
//En el caso de que sean opcionales le agregariamos '?' ===> Dates? dates;


    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;



    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());


  //Fn+f2 para hacer el replace de una palabra por otra.
    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        //creamos un listado de la instancia de Movie(Clase que definimos mas abajo)
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}

class Dates {
    Dates({
       required this.maximum,
       required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

}


