import 'package:flutter/material.dart';

import '../../home/home_page.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
          width: 177,
          child: ImageIcon(
            AssetImage('assets/icon.png'),
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text.rich(
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            height: 1.16,
          ),
          TextSpan(
            text: 'Tudo sobre',
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: ' filmes, séries, animes e muito mais.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Fique por dentro das informações de filmes, séries, animes e muito mais.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5E08B7),
            minimumSize: const Size(100, 40),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Acessar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
