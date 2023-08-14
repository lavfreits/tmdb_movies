import 'package:flutter/material.dart';

class GenreBox extends StatelessWidget {
  const GenreBox({Key? key, this.genre}) : super(key: key);

  final String? genre;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (genre != null) {
      return Container(
        height: 30,
        decoration: ShapeDecoration(
          color: const Color(0xFF2F3142),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              genre!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
