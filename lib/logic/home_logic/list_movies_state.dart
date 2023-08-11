part of 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSucessState extends HomeStates {
  HomeSucessState({required this.movies});

  final List<MovieModel> movies;
}

class HomeErrorState extends HomeStates {
  HomeErrorState({required this.error});

  final String error;
}
