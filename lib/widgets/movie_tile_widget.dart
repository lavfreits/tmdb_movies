import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/list_movies_model.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({required this.movie, required this.onTap, super.key});

  final MovieModel movie;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              fit: BoxFit.fill,
            ),
        ),
    );
  }
}
