import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/search/search.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
 //tengo que especificar el provider que necesito. <MoviesProvider>
 //Coloca la instancia de MoviesProvider en moviesProvider
 final moviesProvider=Provider.of<MoviesProvider>(context);


 print(moviesProvider.onDisplayMovies);


    return Scaffold(
      appBar: AppBar(
        title:Center(child: const Text('Peliculas en cartelera')),
        elevation: 0,
        actions: [
          ChangeThemeButton(),
          IconButton(
            onPressed: ()=>showSearch(context: context, delegate: MovieSearchDelagate()),
             icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child:Column(
        children: [
          //tarjetas principales
          CardSwiper(movies:moviesProvider.onDisplayMovies),
          //listado de peliculas
          MovieSlider(movies:moviesProvider.popularMovies, title:'Populares',onNextPage:()=>{
            moviesProvider.getPopularMovies()
          },),
           MovieSlider(movies:moviesProvider.topRatedMovies, title:'Mejores puntuadas',onNextPage:()=>{
            moviesProvider.getTopRatedMovies()
          },),
           MovieSlider(movies:moviesProvider.upcomingMovies, title:'Proximamente',onNextPage:()=>{
            moviesProvider.getUpcomingMovies()
          },),
          

      ],) ,)
    );
  }
}