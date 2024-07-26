import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/favorites_logic/favorites_bloc.dart';
import '../../../logic/movie_logic/movie_bloc.dart';
import '../../../models/movie_model.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.movieBloc,
    required this.movie,
  }) : super(key: key);

  final MovieBloc movieBloc;
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<MovieBloc, MovieState>(
      bloc: movieBloc,
      builder: (context, state) {
        if (state is MovieSuccessState) {
          return Padding(
            padding: screenSize.width > 800
                ? EdgeInsets.symmetric(
                    vertical: 60, horizontal: screenSize.width * 0.2)
                : screenSize.width > 600
                    ? const EdgeInsets.all(20)
                    : const EdgeInsets.all(15),
            child: FloatingActionButton(
              backgroundColor: const Color(0x00303243).withOpacity(0.65),
              mini: true,
              shape: const CircleBorder(),
              onPressed: () {
                if (state.isFavorite) {
                  movieBloc.add(RemoveMovieFromFavoritesEvent(movie));
                } else {
                  movieBloc.add(AddMovieToFavoritesEvent(movie));
                }

                BlocProvider.of<FavoritesBloc>(context)
                    .add(LoadFavoritesEvent());

                state.isFavorite = !state.isFavorite;
              },
              child: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
