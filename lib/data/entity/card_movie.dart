import 'package:the_movie_db/domain/api/api_links.dart';

class CardMovie {
  final String title;
  final String? posterPath;
  final DateTime? releaseDate;
  final String overview;
  final int id;
  
  // final bool adult;
  // final List<int> genreIDs;
  // final String originalTitle;
  // final String originalLanguage;
  // final String? backdropPath;
  // final double popularity;
  // final int voteCount;
  // final bool video;
  // final double voteAverage;

  CardMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_path': posterPath, 
      'overview': overview,
      'release_date': releaseDate,     
      'title': title,     
    };
  }

  factory CardMovie.fromJson(Map<String, dynamic> map) {
    return CardMovie(
      posterPath: _getImageLink(map['poster_path']),  
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] != null 
      ? DateTime.parse(map['release_date'])
      : null,   
      id: map['id'] ?? 0,          
      title: map['title'] ?? '',                        
    );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'poster_path': posterPath,
  //     'adult': adult,
  //     'overview': overview,
  //     'release_date': releaseDate,
  //     'genre_ids': genreIDs,
  //     'id': id,
  //     'original_title': originalTitle,
  //     'original_language': originalLanguage,
  //     'title': title,
  //     'backdrop_path': backdropPath,
  //     'popularity': popularity,
  //     'vote_count': voteCount,
  //     'video': video,
  //     'vote_average': voteAverage,
  //   };
  // }

  // factory Movie.fromJson(Map<String, dynamic> map) {
  //   return Movie(
  //     posterPath: _getImageLink(map['poster_path']),
  //     adult: map['adult'] ?? false,
  //     overview: map['overview'] ?? '',
  //     releaseDate: map['release_date'] != null 
  //     ? DateTime.parse(map['release_date'])
  //     : null,
  //     genreIDs: List<int>.from(map['genre_ids']),
  //     id: map['id'] ?? 0,
  //     originalTitle: map['original_title'] ?? '',
  //     originalLanguage: map['original_language'] ?? '',
  //     title: map['title'] ?? '',
  //     backdropPath: _getImageLink(map['backdrop_path']),
  //     popularity: map['popularity'] ?? 0.0,
  //     voteCount: map['vote_count'] ?? 0,
  //     video: map['video'] ?? false,
  //     voteAverage: map['vote_average']?.toDouble() ?? 0.0,
  //   );
  }

  static String? _getImageLink(String? path) {
    return path != null 
    ? APILinks.imageHost + path
    : null;
  }
}
