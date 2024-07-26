import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies/presentattion/movie_info/movie_info_page.dart';

import '../models/movie_model.dart';
import 'movie_tile.dart';

class MoviesGrid extends StatefulWidget {
  final ScrollController scrollController;
  final List<MovieModel> movies;

  const MoviesGrid({
    Key? key,
    required this.scrollController,
    required this.movies,
  }) : super(key: key);

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

class _MoviesGridState extends State<MoviesGrid> {
  @override
  Widget build(BuildContext context) {
    var movies = widget.movies;
    final Size screenSize = MediaQuery.of(context).size;

    return GridView.builder(
      dragStartBehavior: DragStartBehavior.start,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width > 800 ? screenSize.width ~/ 300 : 2,
        childAspectRatio: 0.7,
      ),
      controller: widget.scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        if (index == movies.length) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MovieTile(
          movie: movie,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieInfoPage(
                  id: movie.id,
                  movie: movie,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
