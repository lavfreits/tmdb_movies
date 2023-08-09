import 'package:flutter/material.dart';
import 'package:tmdb_movies/data/data_fetch_movie.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class InfoController extends ChangeNotifier {
  bool isLoading = false;
  TitleMovieModel? movie;

  void requestApiMovie(int id) async {
    movie = await fetchDataMovie(id);

    notifyListeners();
  }
}
