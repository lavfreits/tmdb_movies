import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb_movies/data/local_storage.dart';

import '../models/movie_model.dart';
import '../models/provider.dart';
import '../models/title_movie_model.dart';

abstract class MovieDataSource {
  Future<List<MovieModel>> getMovies(int page);

  Future<TitleMovieModel> getMovieDetails(int id);

  Future<CountryProviders> getMovieProviders(int id);

  Future<void> addFavoriteMovie(MovieModel movie);

  Future<void> removeFavoriteMovie(MovieModel movie);

  Future<List<MovieModel>> getFavoriteMovies();
}

class MovieDataSourceImpl implements MovieDataSource {
  final LocalStorage localStorage;

  final _headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjYxNzEwNGYyNjQ2ZDkwNTI0MGQxZjgyODg2MWRmNiIsInN1YiI6IjVkZDk4YWRmMjg3MjNjMDAxMjU2NmJjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wKjxufaKUkyvY9kE7V9loGknl5eRJfrwB7zhOHJz4j8'
  };
  final _baseUrl = 'https://api.themoviedb.org/3';

  MovieDataSourceImpl(this.localStorage);

  @override
  Future<List<MovieModel>> getMovies(int page) async {
    final url =
        Uri.parse('$_baseUrl/movie/top_rated?language=pt-BR&page=$page');

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final movies = <MovieModel>[];

        for (Map<String, dynamic> json in jsonData['results']! as List) {
          movies.add(MovieModel.fromMap(json));
        }
        return movies;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error geting data: $error');
    }
  }

  @override
  Future<TitleMovieModel> getMovieDetails(int id) async {
    final url = Uri.parse('$_baseUrl/movie/$id?language=pt-BR');

    try {
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        TitleMovieModel movie = TitleMovieModel.fromMap(jsonData);

        return movie;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error geting data: $error');
    }
  }

  @override
  Future<CountryProviders> getMovieProviders(int id) async {
    final url = Uri.parse('$_baseUrl/movie/$id/watch/providers?language=pt-BR');

    try {
      final response = await http.get(
        url,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final providers = jsonData['results']['BR'];

        if (jsonData['results'] != null && providers != null) {
          return CountryProviders.fromJson(providers);
        } else {
          return CountryProviders(flatrate: [], buy: [], rent: []);
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error geting data: $error');
    }
  }

  @override
  Future<void> addFavoriteMovie(MovieModel movie) async {
    final favorites = await _getFavoritesList();

    if (!favorites.any((m) => m.id == movie.id)) {
      favorites.add(movie);

      _saveFavoritesList(favorites);
    }
  }

  @override
  Future<void> removeFavoriteMovie(MovieModel movie) async {
    final favorites = await _getFavoritesList();

    favorites.removeWhere((m) => m.id == movie.id);

    _saveFavoritesList(favorites);
  }

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

  Future<List<MovieModel>> _getFavoritesList() async {
    final favoritesStr = await localStorage.read(key: 'favorites');

    if (favoritesStr != null && favoritesStr.isNotEmpty) {
      final List<dynamic> jsonList = json.decode(favoritesStr);

      return jsonList.map((json) => MovieModel.fromMap(json)).toList();
    }
    return [];
  }

  Future<void> _saveFavoritesList(List<MovieModel> favorites) async {
    final updatedFavoritesStr =
        json.encode(favorites.map((m) => m.toMap()).toList());
    await localStorage.write(key: 'favorites', value: updatedFavoritesStr);
  }
}
