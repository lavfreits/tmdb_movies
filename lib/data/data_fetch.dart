import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

Future<List<MovieModel>> fetchData() async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?language=pt-BR&page=1');
  final response = await http.get(url);

  final jsonData = json.decode(response.body);
  final movies = <MovieModel>[];
  for (Map<String, dynamic> json in jsonData['results']! as List) {
    movies.add(MovieModel.fromMap(json));
  }
  // final pagesCount = jsonData['page'] as int;
  return movies;
}
