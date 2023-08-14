part of 'home_bloc.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSucessState extends HomeStates {
  HomeSucessState({required this.movies, required this.page});

  int page;
  final List<MovieModel> movies;
}

class HomeErrorState extends HomeStates {
  HomeErrorState({required this.error});

  final String error;
}
