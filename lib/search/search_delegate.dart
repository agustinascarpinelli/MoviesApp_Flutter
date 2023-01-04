


import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearchDelagate extends SearchDelegate{
@override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar';


  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    //buildActions es una lista de widgets
    return[
      IconButton(
        onPressed:(){
          query='';
        },
       icon:Icon(Icons.clear))
    ];
   
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //buildLeading es un widget
    return IconButton(
      onPressed:(){
        //showdelegate es un future, aca le estoy diciendo con null qu eno devuelva nada (al tocar back)
        close(context, null);
      },
       icon: Icon(Icons.arrow_back));
  }


//Creamos el widget para luego reutilizarlo
 Widget _emptyContainer(){
    return Container(
        child: Center(child: Icon(Icons.movie_creation_outlined,color: Colors.black38,size:100)),
      );
 }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //buildResults es un widget
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //buildSuggestions es un widget
    //Se dispara cada vez que el query cambia
    if (query.isEmpty){
     return _emptyContainer();
    }

    final moviesProvider=Provider.of<MoviesProvider>(context);
    moviesProvider.getSuggestionsQuery(query);
     return StreamBuilder(
      //El future es lo que quiero llamar cada vez que el widget se dispare
      stream:moviesProvider.suggestionStream,
      builder:(_,AsyncSnapshot<List<Movie>> snapshot){
        if(!snapshot.hasData){
             return _emptyContainer();
        }
        final movies=snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_,int index)=>_Suggestion(movie: movies[index]));
      });
  }



}

class _Suggestion extends StatelessWidget {
 final Movie movie;

  const _Suggestion({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
     movie.heroAnimationId='search-${movie.id}';
    return Hero(
      tag:movie.heroAnimationId!,
      child: ListTile(
         leading:FadeInImage(
          image:NetworkImage(movie.fullPosterImg) ,
          width: 50,
          fit:BoxFit.contain,
          placeholder: AssetImage('assets/90OK.gif'),
          ),
          title:Text(movie.title),
          subtitle: Text('Idioma original: ${movie.originalLanguage}'),
          onTap: (){
            Navigator.pushNamed(context, 'details',arguments: movie);
          },
     
      ),
    );
  }
}

