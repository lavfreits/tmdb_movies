import 'package:flutter/material.dart';

import 'widgets/splash_content.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/enter.png",
            fit: BoxFit.cover,
            width: screenSize.width,
            height: screenSize.height,
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xD814151C),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.3, 0.7, 0.9],
                ),
              ),
            ),
          ),
          Padding(
            padding: screenSize.width > 800
                ? EdgeInsets.symmetric(
                    horizontal: screenSize.width > 1000 ? 400 : 200,
                    vertical: screenSize.width > 990 ? 100 : 80,
                  )
                : const EdgeInsets.all(28),
            child: const SplashContent(),
          ),
        ],
      ),
    );
  }
}
