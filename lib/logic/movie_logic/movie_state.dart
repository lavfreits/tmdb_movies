part of 'movie_bloc.dart';

abstract class MovieState {}

class MovieLoadingState extends MovieState {}

class MovieSuccessState extends MovieState {
  final TitleMovieModel movie;
  final List<Provider> movieProviders;
  final List<MovieModel> movies;
  late final bool isFavorite;

  MovieSuccessState({
    required this.movie,
    required this.movieProviders,
    required this.movies,
    required this.isFavorite,
  });

  MovieSuccessState copyWith({
    TitleMovieModel? movie,
    List<Provider>? movieProviders,
    List<MovieModel>? movies,
    bool? isFavorite,
  }) {
    return MovieSuccessState(
      movie: movie ?? this.movie,
      movieProviders: movieProviders ?? this.movieProviders,
      movies: movies ?? this.movies,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class MovieErrorState extends MovieState {
  final String error;

  MovieErrorState({required this.error});
}
