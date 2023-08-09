import 'package:flutter/material.dart';

class GenreBox extends StatelessWidget {
  const GenreBox({super.key, this.genre});

  final genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 31,
      decoration: ShapeDecoration(
        color: Color(0xFF2F3142),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34),
        ),
      ),
      child: Text(
        genre,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
