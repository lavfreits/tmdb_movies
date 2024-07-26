part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchMovieEvent extends MovieEvent {
  final int id;

  FetchMovieEvent(this.id);
}

class AddMovieToFavoritesEvent extends MovieEvent {
  final MovieModel movie;

  AddMovieToFavoritesEvent(this.movie);
}

class RemoveMovieFromFavoritesEvent extends MovieEvent {
  final MovieModel movie;

  RemoveMovieFromFavoritesEvent(this.movie);
}
