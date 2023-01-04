import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';


void main() => runApp(AppState());


//En este widget mantendremos el estado de la aplicacion.Tenemos el AppState antes de MyApp.Llamamos en AppState a MyApp.
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: ( _ )=>MoviesProvider(),lazy: false ), 
    
         //Lazy por defecto esta en true, la instancia del provider se crea cuando se la necesita. Si lo ponemos en false,apenas se crea ell widget AppState, se manda a llamar, la inicializacion del provider
      ],
      child: MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
    create: (context)=>ThemeProvider(),
    builder:(context, _) {
      final themeProvider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Peliculas App',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false, /* Para no mostrar el banner del appBar */
      initialRoute: 'home',
      routes: {
        'home':(_) => const HomeScreen(), /* El argumento '_' es para cuando no lo estamos utilizando */
        'details':(_) =>const DetailsScreen()
      },
    );
        
      
      
    },);
  
}