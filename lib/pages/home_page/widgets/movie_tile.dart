import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({required this.movie, required this.onTap, super.key});

  final MovieModel movie;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AspectRatio(
          aspectRatio: 260 / 310,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
