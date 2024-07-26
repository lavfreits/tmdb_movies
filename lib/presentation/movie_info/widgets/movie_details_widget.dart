import 'package:flutter/material.dart';

import '../../../logic/movie_logic/movie_bloc.dart';
import '../../../models/movie_model.dart';
import '../../../widgets/background.dart';
import '../../../widgets/get_back_button.dart';
import '../../../widgets/movie_list.dart';
import 'favorite_button.dart';
import 'genres_list_widget.dart';
import 'movie_details_header.dart';
import 'provider_list.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    Key? key,
    required this.state,
    required this.screenSize,
    required this.scrollController,
    required this.movieBloc,
    required this.movie,
  }) : super(key: key);

  final MovieBloc movieBloc;
  final MovieSuccessState state;
  final MovieModel movie;
  final Size screenSize;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(imageUrl: state.movie.posterPath),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width > 800 ? screenSize.width * 0.2 : 0,
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.width > 800
                      ? 60
                      : screenSize.width > 600
                          ? 20
                          : 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FavoriteButton(movieBloc: movieBloc, movie: movie)
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 3),
              MovieDetailsHeader(
                state: state,
                screenSize: screenSize,
              ),
              SizedBox(height: 0.02 * screenSize.height),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width > 800
                        ? 0.2 * screenSize.width
                        : 0.08 * screenSize.width),
                child: const Divider(
                  color: Colors.black,
                  thickness: 0.3,
                ),
              ),
              SizedBox(height: 0.02 * screenSize.height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  state.movie.overview,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Color(0xFFCCCCCC),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 0.02 * screenSize.height),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Categoria(s)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 0.02 * screenSize.height),
              GenresList(movie: state.movie),
              SizedBox(height: 0.02 * screenSize.height),
              if (state.movieProviders.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Onde assistir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 0.02 * screenSize.height),
                ProviderList(providers: state.movieProviders),
                SizedBox(height: 0.02 * screenSize.height),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Recomendações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 0.02 * screenSize.height),
              MovieList(
                scrollController: scrollController,
                movies: state.movies,
              ),
              SizedBox(height: 0.02 * screenSize.height),
            ],
          ),
        ),
      ],
    );
  }
}
