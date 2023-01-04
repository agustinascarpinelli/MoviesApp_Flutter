import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';


import '../models/movie.dart';

class CardSwiper extends StatelessWidget {
   final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});
  

  
  @override
  Widget build(BuildContext context) {

    /* MediaQuery es un widget que nos brinda informacion acerca de la plataforma en la que se esta corriendo nuestra aplicacion, las dimensiones, la orientacion, entre otras */ 
    final size= MediaQuery.of(context).size;
    if(movies.length==0){
      return Container(
        width: double.infinity,
        height: size.height *0.5,
        child: Center(child: CircularProgressIndicator()),//todo:cambiar colores
      );
    }

    return Container(
      width: double.infinity, /* Ancho total de la pantalla */
      height: size.height * 0.5 , /* 50% de la pantalla */
      child:Swiper(
        itemCount:10,
        layout: SwiperLayout.STACK,
        itemWidth:size.width * 0.6,
        itemHeight: size.height * 0.4,
        /* Los builder son funciones que se disparan de manera dinamica, para construir el nuevo widget,retornar el widget en si */
        itemBuilder: (_,int index){
           final movie=movies[index];
           //creo el id unico para utilizar el hero en aquellas peliculas que eestan en el card_swiper
 
          movie.heroAnimationId='swiper-${movie.id}';

          /* El widget GestureDetector es el que me permite ponerle el onTap, para que al hacer click sobre la imagen suceda algo */
          return GestureDetector(
            onTap: (() => Navigator.pushNamed(context,'details',arguments: movie)),
            child: Hero(
              //el tag debe ser 'unico, para que el hero pueda funcionar.
              //al ser un argumento opcional (el heroAnimationId debo poner el ! porque si no tira error porque podria no existir.)
              tag:movie.heroAnimationId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  /* El placeholder es la imagen que se deberia de tener en memoria, para cuando se estan cargando las imagenes */
                  placeholder:AssetImage('assets/90OK.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit:BoxFit.cover,
                  ),
              ),
            ),
          );
        },
        )
    );
  }
}