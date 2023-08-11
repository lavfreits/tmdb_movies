import 'package:bloc/bloc.dart';
import 'package:tmdb_movies/data/data_fetch_movie.dart';
import 'package:tmdb_movies/models/movie_model.dart';
part 'movie_state.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitialState());

  Future<void> getMovie(int id) async {
    emit(MovieLoadingState());
    try {
      final movie = await fetchDataMovie(id);

      emit(MovieSucessState(movie: movie));
    } catch (e) {
      emit(MovieErrorState(error: 'Não foi possível carregar o filme.'));
    }
  }
}
