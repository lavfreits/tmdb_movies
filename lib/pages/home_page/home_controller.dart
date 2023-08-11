import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/data/data_fetch.dart';
import 'package:tmdb_movies/models/list_movies_model.dart';

class HomeController extends Cubit<HomeViewModel> {
  HomeController() : super(HomeViewModel());

  void requestApi() async {
    if (state.isLoading) return;
    if (state.page == state.pages) return;
    emit(state.copyWith(isLoading: true));

    final (pages, newMovies) = await fetchData(state.page);
    emit(state.copyWith(
        isLoading: false,
        pages: pages,
        page: state.page + 1,
        movies: [...state.movies, ...newMovies]));
  }
}

class HomeViewModel {
  final List<MovieModel> movies;
  final bool isLoading;
  final int page;
  final int? pages;

  HomeViewModel(
      {this.movies = const [],
      this.isLoading = false,
      this.page = 1,
      this.pages});

  HomeViewModel copyWith({
    List<MovieModel>? movies,
    bool? isLoading,
    int? page,
    int? pages,
  }) =>
      HomeViewModel(
          movies: movies ?? this.movies,
          isLoading: isLoading ?? this.isLoading,
          page: page ?? this.page,
          pages: pages ?? this.pages);
}
