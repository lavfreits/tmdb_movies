class MovieModel {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel.fromMap(Map<String, dynamic> json)
      : adult = json["adult"],
        backdropPath = json["backdrop_path"],
        genreIds = List<int>.from(json["genre_ids"].map((x) => x)),
        id = json["id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        popularity = json["popularity"]?.toDouble(),
        posterPath = json["poster_path"],
        releaseDate = DateTime.parse(json["release_date"]),
        title = json["title"],
        video = json["video"],
        voteAverage = json["vote_average"]?.toDouble(),
        voteCount = json["vote_count"];
}
