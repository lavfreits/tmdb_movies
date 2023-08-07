import 'package:flutter/material.dart';
import 'lib/data/data_fetch.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<MovieModel> movies = [];

  @override
  void initState() {
    requestApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF540BA1),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF540BA1),
              Colors.black.withOpacity(0.9),
            ],
            stops: [0, 0.6],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieTile(movie: movie);
          },
        ),
      ),
    );
  }
}
Future<void> requestApi() async {
    final movies = await fetchData(); // Assuming fetchData returns List<MovieModel>
    setState(() {});
  }

