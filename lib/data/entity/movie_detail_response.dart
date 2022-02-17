class MovieDetailResponse {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbID;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanie> productionCompanies;
  final List<ProductionCountrie> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbID,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'budget': budget,
      'genres': genres.map((x) => x.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbID,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies': productionCompanies.map((x) => x.toJson()).toList(),
      'production_countries': productionCountries.map((x) => x.toJson()).toList(),
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages.map((x) => x.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory MovieDetailResponse.fromJson(Map<String, dynamic> map) {
    return MovieDetailResponse(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'],
      budget: map['budget']?.toInt() ?? 0,
      genres: List<Genre>.from(map['genres']?.map((x) => Genre.fromJson(x))),
      homepage: map['homepage'],
      id: map['id']?.toInt() ?? 0,
      imdbID: map['imdb_id'],
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'],
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'],
      productionCompanies: List<ProductionCompanie>.from(map['production_companies']?.map((x) => ProductionCompanie.fromJson(x))),
      productionCountries: List<ProductionCountrie>.from(map['production_countries']?.map((x) => ProductionCountrie.fromJson(x))),
      releaseDate: map['release_date'] ?? '',
      revenue: map['revenue']?.toInt() ?? 0,
      runtime: map['runtime'],
      spokenLanguages: List<SpokenLanguage>.from(map['spoken_languages']?.map((x) => SpokenLanguage.fromJson(x))),
      status: map['status'] ?? '',
      tagline: map['tagline'],
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
    );
  }
}

class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genre.fromJson(Map<String, dynamic> map) {
    return Genre(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }
}

class ProductionCompanie {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanie({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  factory ProductionCompanie.fromJson(Map<String, dynamic> map) {
    return ProductionCompanie(
      id: map['id']?.toInt() ?? 0,
      logoPath: map['logo_path'],
      name: map['name'] ?? '',
      originCountry: map['origin_country'] ?? '',
    );
  }
}

class ProductionCountrie {
  final String iso;
  final String name;
  ProductionCountrie({
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso,
      'name': name,
    };
  }

  factory ProductionCountrie.fromJson(Map<String, dynamic> map) {
    return ProductionCountrie(
      iso: map['iso_3166_1'] ?? '',
      name: map['name'] ?? '',
    );
  }
}

class SpokenLanguage {
  final String iso;
  final String name;
  SpokenLanguage({
    required this.iso,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso,
      'name': name,
    };
  }

  factory SpokenLanguage.fromJson(Map<String, dynamic> map) {
    return SpokenLanguage(
      iso: map['iso_639_1'] ?? '',
      name: map['name'] ?? '',
    );
  }
}