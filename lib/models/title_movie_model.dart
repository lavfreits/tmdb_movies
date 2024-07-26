class TitleMovieModel {
  final List<String?> genres;
  final int id;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;

  TitleMovieModel.fromMap(Map<String, dynamic> json)
      : genres = List.from(json["genres"].map((x) => x["name"].toString())),
        id = json["id"],
        overview = json["overview"],
        posterPath = json["poster_path"],
        releaseDate = DateTime.parse(json["release_date"]),
        runtime = json["runtime"],
        title = json["title"],
        voteAverage = json["vote_average"]?.toDouble();
}
