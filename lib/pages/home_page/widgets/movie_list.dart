import 'package:flutter/material.dart';
import 'package:tmdb_movies/pages/home_page/home_controller.dart';
import 'package:tmdb_movies/pages/movie_info_page/movie_info_page.dart';

import 'movie_tile.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final scrollController = ScrollController();
  final pageController = HomeController();

//todo: botar init state e dispose na home page e mandar por parametro pra cá tornar widget daqui stateless
  @override
  void initState() {
    pageController.requestApi();
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent -
            scrollController.position.viewportDimension) {
      pageController.requestApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(left: 22, top: 10),
      child: ListenableBuilder(
        listenable: pageController,
        builder: (_, __) {
          return ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: pageController.movies.length +
                (pageController.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == pageController.movies.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final movie = pageController.movies[index];
              return Container(
                width: 150,
                child: MovieTile(
                  movie: movie,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MovieInfo(id: movie.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
