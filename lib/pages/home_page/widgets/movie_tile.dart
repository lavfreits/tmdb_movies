import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class MovieTile extends StatelessWidget {
  final MovieModel movie;

  const MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: Colors.white,
    );
  }
}
