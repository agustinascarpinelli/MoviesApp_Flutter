//Provider: Gestor de estado. Crea unainstancia de una clase y yo puedo acceder a esa informacion directaente desde cualauier widget utilizando el context.
//La idea del provider es que sea un PROVEEDOR DE INFORMACION.
//Si necesitamos que el provider este disponible en toda la aplicacion, tiene que estar en un punto bastante alto de mi arbol de widgets.Si necesitamos que solo este encapsulado a una pantalla, lo podemos inicializar directamente en esa pantalla. (Ambas cosas las realizamos en el main.dart)

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _lng = 'es-ES';
  String _apiKey = '4ed2b8266f37a77441aaaff923df6fa5';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies =[];
  List<Movie> topRatedMovies =[];
  Map<int,List<Movie>> similarsMovies={};
  Map<int, List<Cast>> movieCasting = {};
  int _popularPage = 0;

final debouncer= Debouncer(
  duration: Duration(microseconds: 500),
  );
//emite valores del tipo Lista de movies.
final StreamController<List<Movie>> _suggestionStreamControler=new StreamController.broadcast();
Stream<List<Movie>> get suggestionStream=>this._suggestionStreamControler.stream;

  MoviesProvider() {
    this.getMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
    this.getUpcomingMovies();
  }

//metodo privado
  Future<String> _getData(String endpoint, [int page = 1]) async {
    // page sera opcional, si no mandamos nada por defecto sera 1.
    //base url(sin htpps(se lo agrega solo el Uri)), segemento,parametros(en formato mapa)
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _lng,
      //convierto el int page en string
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getMovies() async {
    final data = await this._getData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();

//El notifyListener les avisa a todos los widgets que usen esta data, cuando hay un cambio en esta .
  }

  getPopularMovies() async {
    _popularPage++;
    final data = await this._getData('3/movie/popular', _popularPage);
    final popularResponse = PopularMovies.fromJson(data);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies()async{
     final data = await this._getData('3/movie/top_rated');
    final topRatedResponse = TopRated.fromJson(data);

   topRatedMovies = [...topRatedMovies, ...topRatedResponse.results];
    notifyListeners();
  }

   getUpcomingMovies()async{
     final data = await this._getData('3/movie/upcoming');
    final upcomingResponse= UpcomingMovies.fromJson(data);

    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];
    notifyListeners();
  }

  Future <List<Movie>> getSimilarMovies(int movieId)async {
    final data=await this._getData('3/movie/$movieId/recommendations');
    final similarResponse=SimilarMovies.fromJson(data);
    similarsMovies[movieId]=similarResponse.results;
    return similarResponse.results;
 

  }


  Future<List<Cast>> getMovieCast(int movieId) async {
    //verifico si ya tengo la respuesta en mi mapa antes de hacer la peticion http
    if (movieCasting.containsKey(movieId)) {
      return movieCasting[movieId]!;
    }
    final data = await this._getData('3/movie/$movieId/credits', _popularPage);
    final creditsResponse = GetCast.fromJson(data);
    movieCasting[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }


Future<List<Movie>>searchMovies(String query)async{
  
     final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lng,
      //convierto el int page en string
      'query':query,
    });

    final response=await http.get(url);
    final searchResponse=SearchMovie.fromJson(response.body);
    return searchResponse.results;
}

void getSuggestionsQuery(String searchTerm){
debouncer.value='';
debouncer.onValue=(value)async{
final results=await this.searchMovies(value);
this._suggestionStreamControler.add(results);
};
final timer=Timer.periodic(Duration(milliseconds: 300), (_) { 
  debouncer.value=searchTerm;
});
//Una milesima de segundos mas.
Future.delayed(Duration(milliseconds: 301)).then((_)=>timer.cancel());
}
}
