import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  HomeController? homeController;

  // late final ListMovieBloc bloc;

//todo: botar init state e dispose na home page e mandar por parametro pra cá tornar widget daqui stateless

  @override
  void didChangeDependencies() {
    if (homeController == null) {
      homeController = context.watch<HomeController>();

      scrollController.addListener(scrollListener);
    }
    //homeController.requestApi();
    super.didChangeDependencies();
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
      homeController!.requestApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(left: 22, top: 10),
      child: Builder(
        builder: (_) {
          return ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: homeController!.state.movies.length,
            // +(homeController!.state.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == homeController!.state.movies.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final movie = homeController!.state.movies[index];
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
