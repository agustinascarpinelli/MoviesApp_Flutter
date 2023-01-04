import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final moviesProvider=Provider.of<MoviesProvider>(context);
    final Movie movie =
        //El argumento es un objeto 'as Movie' lo trata como una pelicula(no lo convierte)
        ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      /* Los slivers son widgets que tienen cierto comportamiento preprogramado cuando se hace scroll en el contenido del padre */
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          /* Lista de Slivers en la cual puedo agregar widgets normales, de lo contrario no podria agregar un widget normal, solo admite slivers */
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie: movie),
            _OverView(
              movie: movie,
            ),
            CastingList(movieId: movie.id),
            
            SimilarMoviesSwiper(movieId: movie.id,title: 'Peliculas similares a ${movie.title}',),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    /* Es un appBar que tiene un comportamiento cuando se hace scroll */
    return SliverAppBar(
        
        expandedHeight: 200,
        floating: false,
        pinned: true,
        /* Por default esta en false, si hago scroll desaparece */
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.all(0),
          title: Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              alignment: Alignment.bottomCenter,
              color: Colors.black12,
              /* Le agrega un blur */
              child: Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )),
          background: FadeInImage(
            placeholder: AssetImage('assets/90OK.gif'),
            image: NetworkImage(movie.fullBackbrogPath),
            fit: BoxFit.cover,
          ),
        ));
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 250,
              child: Hero(
                //Le coloco el mismo id que le puse al anterior Hero para que se produca el hero animation..
                tag:movie.heroAnimationId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/90OK.gif'),
                    image: NetworkImage(movie.fullPosterImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 220),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    movie.originalTitle,
                   
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 15,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${movie.voteAverage}',
                          style: Theme.of(context).textTheme.caption)
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Text(
        movie.overview,
        
        textAlign: TextAlign.justify,
      ),
    );
  }
}
