import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String? imageUrl;

  const Background({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500/$imageUrl',
                fit: screenSize.width > 600 ? BoxFit.fill : BoxFit.cover,
                width: screenSize.width > 600
                    ? screenSize.width * 0.6
                    : screenSize.width,
                height: (screenSize.height / 1.8),
              ),
            if (imageUrl == null)
              Container(
                width: screenSize.width,
                height: (screenSize.height / 1.8),
                color: const Color(0xFF6B05D3),
              )
          ],
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
                const Color(0xFF20212D).withOpacity(0.9),
                const Color(0xFF20212D).withOpacity(1),
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
