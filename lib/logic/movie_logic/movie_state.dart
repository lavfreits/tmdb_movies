part of 'movie_cubit.dart';

abstract class MovieStates {}

class MovieInitialState extends MovieStates {}

class MovieLoadingState extends MovieStates {}

class MovieSucessState extends MovieStates {
  MovieSucessState({required this.movie});

  final TitleMovieModel? movie;
}

class MovieErrorState extends MovieStates {
  MovieErrorState({required this.error});

  final String error;
}
