import 'package:flutter/material.dart';
import 'package:tmdb_movies/data/data_fetch.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class HomeController extends ChangeNotifier {
  List<MovieModel> movies = [];
  bool isLoading = false;
  int page = 1;
  int? pagesCount;

  void requestApi() async {
    if (isLoading) return;
    if (page == this.pagesCount) return;
    isLoading = true;

    final (pagesCount, newMovies) = await fetchData(page);
    page++;
    this.pagesCount = pagesCount;
    print(pagesCount);

    movies.addAll(newMovies);
    isLoading = false;
    notifyListeners();
  }
}
