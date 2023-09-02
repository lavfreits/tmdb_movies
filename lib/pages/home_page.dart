import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/widgets/movie_list_widget.dart';
import 'package:tmdb_movies/logic/home_logic/home_bloc.dart';

import '../models/list_movies_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();
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
      homeBloc.add(LoadMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [
                const Color(0xFF540BA1),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0, 0.4],
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
                width: screenSize.width - 80,
                padding: const EdgeInsets.only(
                    top: 40, bottom: 20, right: 20, left: 40),
                child: const Text(
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
                width: screenSize.width - 5,
                height: 50,
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    homeBloc.add(PerformSearchEvent(value));

                  },
                  controller: textController,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF540BA1).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20
                    ),
                    suffixIcon: const Icon(Icons.search_outlined, color: Colors.white),
                  ),
                ),
              ),
                Container(
                padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
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
                    } else if (state is HomeSucessState ||
                        state is HomeSearchState) {
                      late List<MovieModel> moviesToDisplay;
                      if (state is HomeSucessState) {
                        moviesToDisplay = state.movies;
                      } else if (state is HomeSearchState) {
                        moviesToDisplay = state.filteredMovies;
                      }
                      return MovieList(
                          scrollController: scrollController,
                          movies: moviesToDisplay);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
