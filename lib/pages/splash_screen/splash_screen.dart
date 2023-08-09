import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_page/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/enter.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
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
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0, 0.7, 1.0],
              ),
            ),
          ),
        ),
        const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
        ),
        const Positioned(
          left: 25,
          right: 25,
          bottom: 200,
          child: SizedBox(
            height: 16,
            width: 177,
            child: ImageIcon(
              AssetImage(
                'assets/icon.png',
              ),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
