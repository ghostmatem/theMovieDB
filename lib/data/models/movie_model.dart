import 'package:flutter/material.dart';
import 'package:the_movie_db/data/entity/card_movie.dart';
import 'package:the_movie_db/data/entity/movie_list_response.dart';
import 'package:the_movie_db/data/models/paginations.dart';
import 'package:the_movie_db/domain/api/movie/movie_api_client.dart';
import 'package:the_movie_db/data/entity/movie_view_category.dart';

class MovieModel extends ChangeNotifier {

  String get screenHeader => _headerMap[_category]!;
  bool get hasData => _movies != null;

  List<CardMovie>? get movies => _movies;

  set category (MovieViewCategory value) {
    _category = value;
    setup();
  }

  Future<void> autoUploadingMoviesByIndex(int index) async {
    await paginationDelegate.autoUploadingMoviesByIndex(index, _movies?.length ?? 0);
  }

  Future<MovieListResponse> _getMoves(int page) async {
    return await _movieApiClient.getMoviesOfCategory(
      category: _category, 
      page: page
    );
  }

  void _updateMoves(MovieListResponse resp, bool needAddToEnd) async {
    _movies ??= <CardMovie>[];
    _movies!.addAll(resp.movies);
    notifyListeners();
  }

  Future<void> setup() async {
    paginationDelegate = PaginationDelegate.safety(
      initialPage: 1, 
      loadingOffset: 0, 
      getData: _getMoves, 
      getTotalPages: (data) => data.totalPages,
      getTotalResultOnPage: (data) => data.movies.length,
      updateData: _updateMoves
      );
    await paginationDelegate.setup();
  }

  late final PaginationDelegate<MovieListResponse> paginationDelegate;

  final MovieApiClient _movieApiClient = MovieApiClient();
  MovieViewCategory _category = MovieViewCategory.popular;
  List<CardMovie>? _movies;

  final _headerMap = <MovieViewCategory, String>{
    MovieViewCategory.nowPlaying    : 'Смотрят сейчас',
    MovieViewCategory.popular       : 'Популярные фильмы',
    MovieViewCategory.topRated      : 'Лучшие фильмы',
    MovieViewCategory.upcoming      : 'Ожидаемые фильмы',
  };
}