part of 'home_bloc.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  HomeSuccessState({
    required this.movies,
    required this.populars,
    required this.page,
    required this.popularsPage,
    this.loadingMore = false,
  });

  int page;
  int popularsPage;
  final List<MovieModel> movies;
  final List<MovieModel> populars;
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
