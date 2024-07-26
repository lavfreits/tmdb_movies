import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/movie_logic/movie_bloc.dart';
import '../../models/movie_model.dart';
import 'widgets/movie_details_widget.dart';

class MovieInfoPage extends StatefulWidget {
  const MovieInfoPage({
    Key? key,
    required this.id,
    required this.movie,
  }) : super(key: key);

  final int id;
  final MovieModel movie;

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  late MovieBloc movieBloc;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(FetchMovieEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF20212D),
      body: BlocBuilder<MovieBloc, MovieState>(
        bloc: movieBloc,
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieSuccessState) {
            return MovieDetailsWidget(
              state: state,
              screenSize: screenSize,
              scrollController: scrollController,
              movieBloc: movieBloc,
              movie: widget.movie,
            );
          } else if (state is MovieErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
