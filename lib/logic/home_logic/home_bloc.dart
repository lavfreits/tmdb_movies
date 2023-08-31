import 'package:bloc/bloc.dart';
import 'package:tmdb_movies/data/data_fetch.dart';
import 'package:tmdb_movies/models/list_movies_model.dart';

part 'home_events.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadMoviesEvent>(getMovies);
    on<PerformSearchEvent>(_performSearch);
  }

  Future<void> getMovies(event, emit) async {
    if (state is HomeLoadingState ||
        (state is HomeSucessState && (state as HomeSucessState).loadingMore)) {
      return;
    }

    var page = 1;
    List<MovieModel> movies = [];

    if (state is HomeSucessState) {
      var currentState = state as HomeSucessState;
      page = currentState.page + 1;
      movies = currentState.movies;
      emit(HomeSucessState(
        movies: movies,
        page: page,
        loadingMore: true,
      ));
    } else {
      emit(HomeLoadingState());
    }

    final newMovies = await fetchData(page);
    movies = [...movies, ...newMovies];
    emit(HomeSucessState(movies: movies, page: page));
  }
  Future<void> _performSearch(PerformSearchEvent event, Emitter<HomeStates> emit) async {
    if (state is HomeSucessState) {
      final filteredMovies = (state as HomeSucessState).movies
          .where((movie) => movie.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(HomeSearchState(filteredMovies: filteredMovies));
    }
  }
}
