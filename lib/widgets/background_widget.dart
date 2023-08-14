import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imageUrl;

  const Background({super.key, required this.imageUrl});

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
                Colors.black.withOpacity(1),
                // Color(0xFF21222E),
              ],
              stops: const [0.1, 0.4, 0.5],
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
