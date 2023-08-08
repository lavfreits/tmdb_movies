import 'package:flutter/material.dart';

import '../../data/data_fetch.dart';
import '../../models/movie_model.dart';
import 'widgets/movie_tile.dart';

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
      backgroundColor: const Color(0xFF540BA1),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF540BA1),
              Colors.black.withOpacity(0.9),
            ],
            stops: const [0, 0.6],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
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

  Future<void> requestApi() async {
    movies = await fetchData(); // Assuming fetchData returns List<MovieModel>
    setState(() {});
  }
}
