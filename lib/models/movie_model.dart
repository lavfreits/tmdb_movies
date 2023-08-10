class TitleMovieModel {
  final bool adult;
  final String backdropPath;
  final dynamic belongsToCollection;
  final List<String?> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List productionCompanies;
  final List productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final List spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  TitleMovieModel.fromMap(Map<String, dynamic> json)
      : adult = json["adult"],
        backdropPath = json["backdrop_path"],
        belongsToCollection = json["belongs_to_collection"],
        genres = List.from(json["genres"].map((x) => x["name"].toString())),
        homepage = json["homepage"],
        id = json["id"],
        imdbId = json["imdb_id"],
        originalLanguage = json["original_language"],
        originalTitle = json["original_title"],
        overview = json["overview"],
        popularity = json["popularity"]?.toDouble(),
        posterPath = json["poster_path"],
        productionCompanies =
            List.from(json["production_companies"].map((x) => x)),
        productionCountries =
            List.from(json["production_countries"].map((x) => x)),
        releaseDate = DateTime.parse(json["release_date"]),
        revenue = json["revenue"],
        runtime = json["runtime"],
        spokenLanguages = List.from(json["spoken_languages"].map((x) => x)),
        status = json["status"],
        tagline = json["tagline"],
        title = json["title"],
        video = json["video"],
        voteAverage = json["vote_average"]?.toDouble(),
        voteCount = json["vote_count"];
}
