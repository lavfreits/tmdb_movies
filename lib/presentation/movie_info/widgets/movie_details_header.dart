import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../logic/movie_logic/movie_bloc.dart';
import 'movie_score.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    Key? key,
    required this.state,
    required this.screenSize,
  }) : super(key: key);

  final MovieSuccessState state;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final release = DateFormat('dd/MM/yyyy').format(state.movie.releaseDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MovieScore(state: state),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: screenSize.width > 800
                      ? screenSize.width * 0.4
                      : screenSize.width * 0.7,
                ),
                child: Text(
                  '${state.movie.title} (${state.movie.releaseDate.year})',
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
              Text(
                '${release.toString()} (BR)   - ${formatMinutes(state.movie.runtime)}',
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
    );
  }
}

String formatMinutes(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
}
