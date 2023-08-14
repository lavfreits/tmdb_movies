import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_movies/logic/movie_logic/movie_cubit.dart';
import 'package:tmdb_movies/widgets/background_widget.dart';
import 'package:tmdb_movies/widgets/genres_widget.dart';
import 'package:tmdb_movies/widgets/movie_list_widget.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key, required this.id});

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
    Size screenSize = MediaQuery
        .of(context)
        .size;

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
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back, color: Colors.white),
                              Text(
                                ' Voltar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (screenSize.height / 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.only(left: 10, right: 35),
                            //   child: Column(
                            //     children: [
                            //       // double percentageGoodRating = (infoController.movie!.voteAverage / 10) * 100;
                            //       CircularProgressIndicator(),
                            //     ],
                            //   ),
                            // ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                          maxWidth: screenSize.width - 80),
                                      child: Text(
                                        '${state.movie!.title} (${state.movie!
                                            .releaseDate.year})',
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
                          //screenSize.width / 18,
                          right: 20,
                          //screenSize.width / 18,
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

                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: screenSize.width,
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.movie!.genres.length,
                          itemBuilder: (context, index) {
                            final genre = state.movie!.genres[index];
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: GenreBox(genre: genre),
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 15, top: 30,
                          //screenSize.width / 18,
                          right: 20,
                          //screenSize.width / 18,
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
                      const MovieList(),
                      const SizedBox(height: 60),
                      //ver alguma forma de tentar tirar o titulo q esta aparecendo atraves do id da lista p ele n aparecer
                    ],
                  ),
                ],
              );
            } else if (state is MovieErrorState) {
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
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }
            return Container();
          }),
    );
  }
}
