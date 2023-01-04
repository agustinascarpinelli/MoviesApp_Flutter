import 'package:flutter/cupertino.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/credits_response.dart';

class CastingList extends StatelessWidget {
  final int movieId;

  const CastingList({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    //listen:false ya que no me interesa redibujar el widget si hay cambios
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }
//le aseguro con el ! que vendra data ya que ya hice la evaluacion anteriormente.
        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(
                    actor: cast[index],
                  )),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/90OK.gif'),
                      image: NetworkImage(actor.fullProfilePath),
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 1,
              child: Text(
                actor.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
