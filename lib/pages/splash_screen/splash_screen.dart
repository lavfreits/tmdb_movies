import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_page/home_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            "assets/enter.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xD814151C),
                  Colors.black.withOpacity(0.9),
                ],
                stops: [0, 0.7, 1.0],
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        Positioned(
          left: 25,
          right: 25,
          bottom: 200,
          child: Container(
            height: 16,
            width: 177,
            child: const ImageIcon(
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
