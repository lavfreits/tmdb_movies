import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/favorites_data_source.dart';
import '../../models/movie_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesDataSource dataSource;

  FavoritesBloc(this.dataSource) : super(FavoritesLoading()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
  }

  void _onLoadFavorites(event, emit) async {
    try {
      List<MovieModel> favorites = await dataSource.getFavoriteMovies();

      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
