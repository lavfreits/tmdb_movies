import 'package:flutter/material.dart';
import 'package:tmdb_movies/pages/movie_info_page.dart';
import 'dart:ui';

import '../models/list_movies_model.dart';
import 'movie_tile_widget.dart';

class MovieList extends StatefulWidget {
  final ScrollController? scrollController;
  final List<MovieModel> movies;

  const MovieList({
    Key? key,
    required this.scrollController,
    required this.movies,
  }) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    var movies = widget.movies;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      controller: widget.scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieTile(
          movie: movie,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieInfo(id: movie.id, movies: movies),
              ),
            );
          },
        );
      },
    );
  }
}
