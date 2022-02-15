import 'package:the_movie_db/data/entity/card_movie.dart';

class MovieListResponse {
  final int page;
  final List<CardMovie> movies;
  final Dates? dates;
  final int totalResults;
  final int totalPages;
  MovieListResponse({
    required this.page,
    required this.movies,
    required this.dates,
    required this.totalResults,
    required this.totalPages,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': movies.map((x) => x.toJson()).toList(),
      'total_results': totalResults,
      'total_pages': totalPages,
    };
  }

  factory MovieListResponse.fromJson(Map<String, dynamic> map) {
    return MovieListResponse(
      page: map['page'] ?? 0,
      movies: List<CardMovie>.from(map['results']?.map((x) => CardMovie.fromJson(x))),
      dates: map['dates'] != null 
      ? Dates.fromJson(map['dates'])
      : null,
      totalResults: map['total_results'] ?? 0,
      totalPages: map['total_pages'] ?? 0,
    );
  }
}

class Dates {
  final DateTime minimum;
  final DateTime maximum;
  
  Dates({
    required this.minimum,
    required this.maximum,
  });

  Map<String, dynamic> toJson() {
    return {
      'minimum': minimum,
      'maximum': maximum,
    };
  }

  factory Dates.fromJson(Map<String, dynamic> map) {
    return Dates(
      minimum: DateTime.parse(map['minimum']),
      maximum: DateTime.parse(map['maximum']),
    );
  }
}

