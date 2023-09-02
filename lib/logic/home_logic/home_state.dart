part of 'home_bloc.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSucessState extends HomeStates {
  HomeSucessState({
    required this.movies,
    required this.page,
    this.loadingMore = false,
  });

  int page;
  final List<MovieModel> movies;
  bool loadingMore;
}

class HomeErrorState extends HomeStates {
  HomeErrorState({required this.error});

  final String error;
}

class HomeSearchState extends HomeStates {
  final List<MovieModel> filteredMovies;

  HomeSearchState({required this.filteredMovies});
}
