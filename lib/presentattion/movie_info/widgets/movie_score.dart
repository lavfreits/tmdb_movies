import 'package:flutter/material.dart';

import '../../../logic/movie_logic/movie_bloc.dart';

class MovieScore extends StatelessWidget {
  const MovieScore({
    Key? key,
    required this.state,
  }) : super(key: key);

  final MovieSuccessState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFF15161D),
          child: Text(
            state.movie.voteAverage.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
            value: state.movie.voteAverage / 10,
            backgroundColor: const Color(0xFF303241),
            color: const Color(0xFFFB1F88),
          ),
        ),
      ],
    );
  }
}
