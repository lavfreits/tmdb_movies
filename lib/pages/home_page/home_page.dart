import 'package:flutter/material.dart';
import 'package:tmdb_movies/pages/movie_info/movie_info.dart';

import 'home_controller.dart';
import 'widgets/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final pageController = HomeController();

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
    return Scaffold(
      backgroundColor: const Color(0xFF540BA1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF540BA1),
              Colors.black.withOpacity(0.8),
            ],
            stops: const [0, 0.6],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              width: 280,
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, right: 20, left: 40),
              child: Text(
                'O que você quer assistir hoje?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: 400,
              height: 50,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Color(0xFF540BA1).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  suffixIcon: Icon(Icons.search_outlined, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 22, top: 10),
              child: ListenableBuilder(
                listenable: pageController,
                builder: (_, __) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pageController.movies.length +
                        (pageController.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == pageController.movies.length) {
                        return const Center(
                          //todo: tirei o padding
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
                                builder: (context) => MovieInfo(),
                                settings: RouteSettings(arguments: movie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, right: 20, left: 40),
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
            Container(
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
                          //todo: tirei o padding
                          // child: Padding(
                          //   padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
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
                                builder: (context) => MovieInfo(),
                                settings: RouteSettings(arguments: movie),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
