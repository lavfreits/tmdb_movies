import 'package:flutter/material.dart';

import '../models/movie_model.dart';
import '../presentation/movie_info/movie_info_page.dart';
import 'movie_tile.dart';
import 'scroll_button.dart';

class MovieList extends StatefulWidget {
  final List<MovieModel> movies;
  final ScrollController scrollController;

  const MovieList({
    Key? key,
    required this.movies,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final screenSizeWidth = MediaQuery.of(context).size.width;

    var movies = widget.movies;
    return SizedBox(
      height: 250,
      child: Row(
        children: [
          if (screenSizeWidth > 600)
            ScrollButton(
              icon: Icons.arrow_back_ios,
              controller: widget.scrollController,
              offset: -200,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: widget.scrollController,
              itemCount: movies.length + 1,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final movie = movies[index];
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
            ),
          ),
          if (screenSizeWidth > 600)
            ScrollButton(
              icon: Icons.arrow_forward_ios,
              controller: widget.scrollController,
              offset: 200,
            )
        ],
      ),
    );
  }
}
