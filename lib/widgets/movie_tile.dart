import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    required this.movie,
    required this.onTap,
    super.key,
  });

  final MovieModel movie;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 40,
                ),
              );
            },
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
