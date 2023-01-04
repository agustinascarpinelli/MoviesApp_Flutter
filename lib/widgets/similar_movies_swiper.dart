import 'package:flutter/cupertino.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/credits_response.dart';

class SimilarMoviesSwiper extends StatelessWidget {
  final int movieId;
  final String title;

  const SimilarMoviesSwiper(
      {super.key, required this.movieId, required this.title});

  @override
  Widget build(BuildContext context) {
    //listen:false ya que no me interesa redibujar el widget si hay cambios
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getSimilarMovies(movieId),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }
//le aseguro con el ! que vendra data ya que ya hice la evaluacion anteriormente.
        final List<Movie> movies = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                //signo de ! en this.title para que dart confie enque no sera nulo (ya que puede serlo por ser opcional, pero yo hice la validacion)
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) => _CastCard(
                          movie: movies[index],
                        )),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Movie movie;

  const _CastCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroAnimationId = 'similar-${movie.id}';
    return Container(
        width: 130,
        height: 190,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: movie),
                child: Hero(
                  tag: movie.heroAnimationId!,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                          placeholder: AssetImage('assets/90OK.gif'),
                          image: NetworkImage(movie.fullPosterImg),
                          height: 190,
                          width: 130,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 1,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
