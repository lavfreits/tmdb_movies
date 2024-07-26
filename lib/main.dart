import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/data/local_storage.dart';

import 'data/favorites_data_source.dart';
import 'data/movie_data_source.dart';
import 'logic/favorites_logic/favorites_bloc.dart';
import 'logic/home_logic/home_bloc.dart';
import 'logic/movie_logic/movie_bloc.dart';
import 'presentattion/splash/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorage localStorage = LocalStorageImplementation();
    MovieDataSource movieDataSource = MovieDataSourceImpl(localStorage);
    FavoritesDataSource favoritesDataSource =
        FavoritesDataSourceImpl(localStorage);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => MovieBloc(movieDataSource)),
        BlocProvider(create: (_) => FavoritesBloc(favoritesDataSource)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
