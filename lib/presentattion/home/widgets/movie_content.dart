import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/home_logic/home_bloc.dart';
import '../../../widgets/movie_list.dart';
import '../../../widgets/movies_grid.dart';

class MovieContent extends StatelessWidget {
  final HomeBloc homeBloc;
  final ScrollController scrollController;
  final ScrollController scrollControllerPopulars;
  final ScrollController scrollControllerSearch;
  final Size screenSize;

  const MovieContent({
    super.key,
    required this.homeBloc,
    required this.scrollController,
    required this.scrollControllerPopulars,
    required this.scrollControllerSearch,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height - 230,
      child: BlocBuilder<HomeBloc, HomeStates>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeErrorState) {
            return ErrorWidget(state.error);
          } else if (state is HomeSuccessState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieList(
                    scrollController: scrollController,
                    movies: state.movies,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Mais populares',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  MovieList(
                    scrollController: scrollControllerPopulars,
                    movies: state.populars,
                  ),
                ],
              ),
            );
          } else if (state is HomeSearchState) {
            if (state.filteredMovies.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum resultado encontrado',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return MoviesGrid(
                scrollController: scrollControllerSearch,
                movies: state.filteredMovies,
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
