import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

abstract class HomeDataSource {
  Future<List<MovieModel>> getMoviesData(int page);

  Future<List<MovieModel>> searchMovies(String query);

  Future<List<MovieModel>> getPopularMovies(int page);
}

class HomeDataSourceImpl implements HomeDataSource {
  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjYxNzEwNGYyNjQ2ZDkwNTI0MGQxZjgyODg2MWRmNiIsInN1YiI6IjVkZDk4YWRmMjg3MjNjMDAxMjU2NmJjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wKjxufaKUkyvY9kE7V9loGknl5eRJfrwB7zhOHJz4j8';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  @override
  Future<List<MovieModel>> getMoviesData(int page) async {
    final response = await _get('/movie/top_rated?language=pt-BR&page=$page');

    if (response.statusCode == 200) {
      return _parseMovies(response.body);
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await _get('/search/movie?query=$query&language=pt-BR');

    if (response.statusCode == 200) {
      return _parseMovies(response.body);
    } else {
      throw Exception('Failed to search movies');
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies(int page) async {
    final response = await _get('/movie/popular?language=pt-BR&page=$page');

    if (response.statusCode == 200) {
      return _parseMovies(response.body);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<http.Response> _get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_apiKey',
      });
      return response;
    } catch (error) {
      throw Exception('Error geting data: $error');
    }
  }

  List<MovieModel> _parseMovies(String responseBody) {
    final jsonData = json.decode(responseBody);
    final movies = <MovieModel>[];

    if (jsonData['results'] != null) {
      for (Map<String, dynamic> json in jsonData['results'] as List) {
        movies.add(MovieModel.fromMap(json));
      }
    }

    return movies;
  }
}
