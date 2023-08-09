import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_movies/pages/home_page/widgets/movie_list.dart';

import 'movie_info_controller.dart';
import 'widgets/background.dart';
import 'widgets/genres.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key, required this.id});

  final int id;

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  final InfoController infoController = InfoController();

  @override
  void initState() {
    infoController.requestApiMovie(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final release =
        DateFormat('dd/MM/yyyy').format(infoController.movie!.releaseDate);

    return Scaffold(
      body: ListenableBuilder(
          listenable: infoController,
          builder: (_, __) {
            if (infoController.movie != null) {
              return Stack(
                children: [
                  Background(imageUrl: infoController.movie!.posterPath),
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 35),
                              child: Column(
                                children: [
                                  // double percentageGoodRating = (infoController.movie!.voteAverage / 10) * 100;
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${infoController.movie!.title} (${infoController.movie!.releaseDate.year})',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${release.toString()} (BR)',
                                      style: TextStyle(
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
                          infoController.movie!.overview,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Color(0xFFCCCCCC),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        'Categoria(s)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        height: screenSize.height / 20,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: infoController.movie!.genres.length,
                          itemBuilder: (context, index) {
                            final genre = infoController.movie!.genres[index];
                            return Container(
                              width: 30,
                              child: GenreBox(genre: genre!),
                            );
                          },
                        ),
                      ),

                      Text(
                        'Recomendações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      MovieList(),
                      SizedBox(height: 30),
                      //ver alguma forma de tentar tirar o titulo q esta aparecendo atraves do id da lista p ele n aparecer
                    ],
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
