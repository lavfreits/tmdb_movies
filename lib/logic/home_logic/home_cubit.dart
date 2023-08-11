import 'package:bloc/bloc.dart';
import 'package:tmdb_movies/data/data_fetch.dart';
import 'package:tmdb_movies/models/list_movies_model.dart';

part 'list_movies_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  Future<void> getMovies(int page) async {
    List<MovieModel> movies = [];
    emit(HomeLoadingState());

    try {
      final newMovies = await fetchData(page);
      movies = [...movies, ...newMovies];
      emit(HomeSucessState(movies: movies));
      page++;
    } catch (e) {
      emit(HomeErrorState(
          error: 'Não foi possível carregar a lista de filmes.'));
    }
  }
}
