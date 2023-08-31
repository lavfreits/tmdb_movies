import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_movies/logic/movie_logic/movie_cubit.dart';
import 'package:tmdb_movies/widgets/background_widget.dart';
import 'package:tmdb_movies/widgets/movie_list_widget.dart';

import '../models/list_movies_model.dart';
import '../widgets/genres_list_widget.dart';
import '../widgets/get_back_button.dart';

class MovieInfo extends StatefulWidget {
  final List<MovieModel> movies;

  const MovieInfo({super.key, required this.id, required this.movies});

  final int id;

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  final MovieCubit movieCubit = MovieCubit();

  @override
  void initState() {
    movieCubit.getMovie(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF540BA1),
      body: BlocBuilder<MovieCubit, MovieStates>(
          bloc: movieCubit,
          builder: (context, state) {
            if (state is MovieLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieSucessState) {
              final release =
                  DateFormat('dd/MM/yyyy').format(state.movie!.releaseDate);
              return Stack(
                children: [
                  Background(imageUrl: state.movie!.posterPath),
                  ListView(
                    children: [
                      GetBackButton(onPressed: () {
                        Navigator.of(context).pop();
                       },),
                      SizedBox(
                        height: (screenSize.height / 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                          maxWidth: screenSize.width - 80),
                                      child: Text(
                                        '${state.movie!.title} (${state.movie!.releaseDate.year})',
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${release.toString()} (BR)',
                                      style: const TextStyle(
                                        color: Color(0xFFBBBBBB),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenSize.width / 18,
                            left: screenSize.width / 18,
                            top: 10,
                            bottom: 10),
                        child: Text(
                          state.movie!.overview,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Color(0xFFCCCCCC),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 20, top: 10,
                          right: 20,
                        ),
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

                      GenresList(
                        movie: state.movie!,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 15, top: 30,
                          right: 20,
                        ),
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
                      MovieList(
                        scrollController: null,
                        movies: widget.movies,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ],
              );
            } else if (state is MovieErrorState) {
              return ErrorWidget(state.error);
            }
            return Container();
          }),
    );
  }
}
