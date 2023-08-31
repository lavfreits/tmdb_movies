import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';

import 'genre_widget.dart';

class GenresList extends StatelessWidget {
  final TitleMovieModel movie;
  const GenresList({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: screenSize.width,
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movie.genres.length,
        itemBuilder: (context, index) {
          final genre = movie.genres[index];
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: GenreBox(genre: genre),
          );
        },
      ));
  }
}
