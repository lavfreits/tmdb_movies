import 'dart:convert';

import 'package:tmdb_movies/data/local_storage.dart';

import '../models/movie_model.dart';

abstract class FavoritesDataSource {
  Future<List<MovieModel>> getFavoriteMovies();
}

class FavoritesDataSourceImpl implements FavoritesDataSource {
  final LocalStorage localStorage;

  FavoritesDataSourceImpl(this.localStorage);

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    final favoritesStr = await localStorage.read(key: 'favorites');

    if (favoritesStr != null && favoritesStr.isNotEmpty) {
      final List<dynamic> jsonList = json.decode(favoritesStr);

      return jsonList.map((json) => MovieModel.fromMap(json)).toList();
    } else {
      return [];
    }
  }
}
