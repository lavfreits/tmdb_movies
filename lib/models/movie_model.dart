class MovieModel {
  final int id;
  final String posterPath;

  MovieModel({
    required this.id,
    required this.posterPath,
  });

  MovieModel.fromMap(Map<String, dynamic> json)
      : id = json["id"],
        posterPath = json["poster_path"] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
    };
  }
}
