import 'package:flutter/material.dart';
import 'package:tmdb_movies/data/data_fetch.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class HomeController extends ChangeNotifier {
  List<MovieModel> movies = [];
  bool isLoading = false;
  int page = 1;
  int? pages;

  void requestApi() async {
    if (isLoading) return;
    if (page == this.pages) return;
    isLoading = true;

    final (pages, newMovies) = await fetchData(page);
    page++;
    this.pages = pages;
    print(pages);

    movies.addAll(newMovies);
    isLoading = false;
    notifyListeners();
  }
}
