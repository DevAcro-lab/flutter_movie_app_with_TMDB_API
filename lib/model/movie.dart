class Movie {
  final int id;
  final String title;
  final String overview;
  final String originalLanguage;
  final double popularity;
  final bool adult;
  final String posterPath;
  final String backdropPath;
  final String releaseData;
  final bool video;
  final double averageVote;
  final int voteCount;

  Movie(
      this.id,
      this.title,
      this.overview,
      this.originalLanguage,
      this.popularity,
      this.adult,
      this.posterPath,
      this.backdropPath,
      this.releaseData,
      this.video,
      this.averageVote,
      this.voteCount);

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_title': title,
        'overview': overview,
        'original_language': originalLanguage,
        'popularity': popularity,
        'adult': adult,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'release_date': releaseData,
        'video': video,
        'vote_average': averageVote,
        'vote_count': voteCount,
      };

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['original_title'] ?? "",
        overview = json['overview'] ?? "",
        originalLanguage = json['original_language'] ?? "",
        popularity = json['popularity'].toDouble(),
        adult = json['adult'] ?? false,
        posterPath = json['poster_path'] ?? "",
        backdropPath = json['backdrop_path'] ?? "",
        releaseData = json['release_date'] ?? "",
        video = json['video'],
        averageVote = json['vote_average'].toDouble(),
        voteCount = json['vote_count'] ?? 0;
}
