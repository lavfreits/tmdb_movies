import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imageUrl;

  Background({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/$imageUrl',
          fit: BoxFit.cover,
          width: screenSize.width,
          height: (screenSize.height / 1.8),
        ),
        Container(
          height: (screenSize.height),
          width: screenSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.9),
                // Color(0xFF21222E),
              ],
              stops: const [0.2, 0.5],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
/*Image.network(
                    infoController.movie.posterPath,
                    width: double.infinity,
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
                  ),*/
