import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/list_movies_model.dart';

Future<(int, List<MovieModel>)> fetchData(int page) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?language=pt-BR&page=$page');

  try {
    final response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MjYxNzEwNGYyNjQ2ZDkwNTI0MGQxZjgyODg2MWRmNiIsInN1YiI6IjVkZDk4YWRmMjg3MjNjMDAxMjU2NmJjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wKjxufaKUkyvY9kE7V9loGknl5eRJfrwB7zhOHJz4j8'
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final movies = <MovieModel>[];
      for (Map<String, dynamic> json in jsonData['results']! as List) {
        movies.add(MovieModel.fromMap(json));
      }
      final pagesCount = jsonData['page'] as int;
      return (pagesCount, movies);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    throw Exception('Error fetching data: $error');
  }
}
