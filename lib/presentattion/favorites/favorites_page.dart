import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/widgets/background.dart';
import 'package:tmdb_movies/widgets/get_back_button.dart';
import 'package:tmdb_movies/widgets/movies_grid.dart';

import '../../logic/favorites_logic/favorites_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final ScrollController scrollController;
  late final FavoritesBloc favoritesBloc;

  @override
  void initState() {
    favoritesBloc = BlocProvider.of<FavoritesBloc>(context);

    scrollController = ScrollController();

    favoritesBloc.add(LoadFavoritesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const Background(imageUrl: null),
          SingleChildScrollView(
            child: Padding(
              padding: screenSize.width < 800
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.fromLTRB(250, 80, 250, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 10),
                    child: GetBackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.025),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 20),
                    child: Text(
                      'Favoritos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, state) {
                      if (state is FavoritesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavoritesLoaded) {
                        if (state.favorites.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Center(
                              child: Text(
                                'Nenhum filme favorito',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          width: screenSize.width > 800
                              ? screenSize.width * 0.8
                              : screenSize.width * 0.95,
                          height: screenSize.height * 0.8,
                          child: MoviesGrid(
                            scrollController: scrollController,
                            movies: state.favorites,
                          ),
                        );
                      } else if (state is FavoritesError) {
                        return Center(
                          child: Text(
                            'Erro: ${state.message}',
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
