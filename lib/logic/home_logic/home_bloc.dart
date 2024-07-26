import 'package:bloc/bloc.dart';
import 'package:tmdb_movies/data/home_data_source.dart';

import '../../models/movie_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStates> {
  HomeDataSource dataSource = HomeDataSourceImpl();

  HomeBloc() : super(HomeInitialState()) {
    on<LoadMoviesEvent>(getMovies);
    on<PerformSearchEvent>(_performSearch);
  }

  Future<void> getMovies(event, emit) async {
    if (state is HomeLoadingState ||
        (state is HomeSuccessState &&
            (state as HomeSuccessState).loadingMore)) {
      return;
    }

    var page = 1;
    var pagePopulars = 1;

    List<MovieModel> movies = [];
    List<MovieModel> populars = [];

    if (state is HomeSuccessState) {
      var currentState = state as HomeSuccessState;

      pagePopulars = currentState.popularsPage + 1;

      populars = currentState.populars;

      page = currentState.page + 1;

      movies = currentState.movies;

      emit(HomeSuccessState(
        movies: movies,
        populars: populars,
        page: page,
        loadingMore: true,
        popularsPage: pagePopulars,
      ));
    } else {
      emit(HomeLoadingState());
    }
    if (page == 1 && pagePopulars == 1) {
      final newMovies = await dataSource.getMoviesData(page);
      movies = [...movies, ...newMovies];

      final newPopulars = await dataSource.getPopularMovies(pagePopulars);
      populars = [...populars, ...newPopulars];
    } else if (event.isPopular) {
      final newPopulars = await dataSource.getPopularMovies(pagePopulars);

      populars = [...populars, ...newPopulars];
    } else {
      final newMovies = await dataSource.getMoviesData(page);

      movies = [...movies, ...newMovies];
    }

    emit(HomeSuccessState(
      movies: movies,
      populars: populars,
      page: page,
      popularsPage: pagePopulars,
    ));
  }

  Future<void> _performSearch(event, emit) async {
    if (event.query.isNotEmpty) {
      final searchResult = await dataSource.searchMovies(event.query);

      emit(HomeSearchState(filteredMovies: searchResult));
    }
  }
}
