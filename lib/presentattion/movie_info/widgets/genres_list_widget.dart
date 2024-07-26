import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/title_movie_model.dart';
import 'package:tmdb_movies/widgets/scroll_button.dart';

import 'rounded_box.dart';

class GenresList extends StatelessWidget {
  final TitleMovieModel movie;

  const GenresList({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSizeWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();

    return SizedBox(
      width: screenSizeWidth,
      height: 40,
      child: Row(
        children: [
          if (screenSizeWidth > 600 && movie.genres.length > 5)
            ScrollButton(
              icon: Icons.arrow_back_ios,
              controller: scrollController,
              offset: -200,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movie.genres.length,
              padding: const EdgeInsets.only(left: 10),
              itemBuilder: (context, index) {
                final genre = movie.genres[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: RoundedBox(name: genre),
                );
              },
            ),
          ),
          if (screenSizeWidth > 600 && movie.genres.length > 5)
            ScrollButton(
              icon: Icons.arrow_forward_ios,
              controller: scrollController,
              offset: 200,
            ),
        ],
      ),
    );
  }
}
