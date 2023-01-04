import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {super.key, required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  //El ScrollController me permite crear un listener, tiene que estar asociado a otro widget que use un scroll(un ListView o cualquier cosa que use un scroll)
  final ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    // InitState ejecuta codigo la primera vez que este widget es construido
    super.initState();
    scrollController.addListener(() {
      //scrollController.position.maxScrollEtent es el la posicion de la ultima slider, le resto 500 para que la peticion no se haga cuando lleguemos al final sino cuando estemos cerca
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();

        // print('LLamar provider');
      }
    });
  }

  @override
  void dispose() {
    //Dispose ejecuta codigo cuando el widget es destruido
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      /* Las columnas sirven para colocar widgets uno debajo de otros (en columna) */
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (this.widget.title != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(this.widget.title!,
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
            //referencia al scrollControler
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (_, int index) =>
                _MoviePoster(movie: widget.movies[index]),
          ),
        )
      ]),
    );
  }
}

/* Creamos un widget privado anteponiendo el '_' en el nombre del widget. Al ser privado no lo podremos importar y solo podremos utilizarlo dentro del movieSlider */

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroAnimationId = 'slider-${movie.id}';
    return Container(
        width: 130,
        height: 190,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                overflow: TextOverflow.ellipsis,
                /* Si el largo del texto supera el espacio total coloca los tres puntos para indicar que hay mas texto */
                maxLines: 2,
                /* Maximo de dos lineas */
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
