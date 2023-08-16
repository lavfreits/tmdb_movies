import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/logic/home_logic/home_bloc.dart';
import 'package:tmdb_movies/logic/home_logic/home_events.dart';
import 'package:tmdb_movies/pages/movie_info_page.dart';

import 'movie_tile_widget.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController scrollController = ScrollController();
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(LoadMoviesEvent());
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    homeBloc.close();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent -
            scrollController.position.viewportDimension) {
      // page++;
      homeBloc.add(LoadMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 22, top: 10),
      height: 250,
      child: BlocBuilder<HomeBloc, HomeStates>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSucessState) {
            return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
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
          } else if (state is HomeErrorState) {
            return Column(
              // padding: const EdgeInsets.only(left: 22),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.not_interested_outlined,
                    size: 30.0, color: Colors.white),
                const SizedBox(height: 16.0),
                Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
