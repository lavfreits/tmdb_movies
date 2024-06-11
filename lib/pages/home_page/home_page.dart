import 'package:flutter/material.dart';
import 'package:tmdb_movies/pages/home_page/widgets/movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150,
                width: 280,
                padding: const EdgeInsets.only(
                    top: 40, bottom: 20, right: 20, left: 40),
                child: Text(
                  'O que você quer assistir hoje?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 50,
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: Color(0xFF540BA1).withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    suffixIcon:
                        Icon(Icons.search_outlined, color: Colors.white),
                  ),
                ),
              ),
              MovieList(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 20, right: 20, left: 40),
                child: Text(
                  'Mais populares',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              MovieList(),
            ],
          ),
        ),
      ),
    );
  }
}
