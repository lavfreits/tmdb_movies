import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final Size screenSize;

  const HomeBackground({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6B05D3),
            Color(0xFF3C106F),
            Color(0xFF16171F),
          ],
          stops: [0, 0.2, 0.4],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
