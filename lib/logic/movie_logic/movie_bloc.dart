import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/movie_data_source.dart';
import '../../models/movie_model.dart';
import '../../models/provider.dart';
import '../../models/title_movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieDataSource dataSource;

  MovieBloc(this.dataSource) : super(MovieLoadingState()) {
    on<FetchMovieEvent>(_onFetchMovie);
    on<AddMovieToFavoritesEvent>(_onAddMovieToFavorites);
    on<RemoveMovieFromFavoritesEvent>(_onRemoveMovieFromFavorites);
  }

  Future<void> _onFetchMovie(event, emit) async {
    emit(MovieLoadingState());

    try {
      final movie = await dataSource.getMovieDetails(event.id);
      final movieProviders = await dataSource.getMovieProviders(event.id);
      final movies = await dataSource.getMovies(1);
      final favoriteMovies = await dataSource.getFavoriteMovies();

      final isFavorite =
          favoriteMovies.any((element) => element.id == movie.id);

      final providers = [
        ...movieProviders.flatrate,
        ...movieProviders.buy,
        ...movieProviders.rent
      ];

      emit(MovieSuccessState(
        movie: movie,
        movieProviders: providers,
        movies: movies,
        isFavorite: isFavorite,
      ));
    } catch (e) {
      emit(MovieErrorState(error: 'Não foi possível carregar o filme.'));
    }
  }

  Future<void> _onAddMovieToFavorites(event, emit) async {
    if (state is MovieSuccessState) {
      final currentState = state as MovieSuccessState;

      try {
        await dataSource.addFavoriteMovie(event.movie);

        emit(currentState.copyWith(isFavorite: true));
      } catch (e) {
        emit(MovieErrorState(
            error: 'Não foi possível adicionar o filme aos favoritos.'));
      }
    }
  }

  Future<void> _onRemoveMovieFromFavorites(event, emit) async {
    if (state is MovieSuccessState) {
      final currentState = state as MovieSuccessState;

      try {
        await dataSource.removeFavoriteMovie(event.movie);

        emit(currentState.copyWith(isFavorite: false));
      } catch (e) {
        emit(MovieErrorState(
            error: 'Não foi possível remover o filme dos favoritos.'));
      }
    }
  }
}
