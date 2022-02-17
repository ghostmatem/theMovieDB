import 'package:flutter/material.dart';
import 'package:the_movie_db/data/entity/card_movie.dart';
import 'package:the_movie_db/data/entity/movie_list_response.dart';
import 'package:the_movie_db/data/models/loading_page_manager.dart';
import 'package:the_movie_db/domain/api/movie/movie_api_client.dart';
import 'package:the_movie_db/data/entity/movie_view_category.dart';

class MovieModel extends ChangeNotifier {

  String get screenHeader => CategoryRoot.getDataByCategory(_category).header;
  bool get hasData => _movies.isNotEmpty;

  List<CardMovie>? get movies => _movies;

  int get paginationBeginningWith => _movies.length - 1 - _uploadOffset;

  void setCategory (MovieViewCategory value) {
    _category = value;
    setup();
  }

  Future<void> setup() async {
    _pageManager = LoadingPageManager();
    _movies.clear();
    
    await _loadNextPageWithMovies();
  }

  Future<void> tryLoadNextPage() async{
    if (_pageManager.loadingIsProgress
    || _pageManager.nextPage == null) return;
    
    await _loadNextPageWithMovies();
  }
 
  final int _uploadOffset = 5;
  final MovieApiClient _movieApiClient = MovieApiClient();
  MovieViewCategory _category = MovieViewCategory.popular;
  final List<CardMovie> _movies = [];
  late LoadingPageManager _pageManager;

  Future<void> _loadNextPageWithMovies() async {
    _pageManager.loadingIsProgress = true;
    final response = await _movieApiClient.getMoviesOfCategory(
      category: _category, 
      page: _pageManager.nextPage!
    );

    _updateValues(response);
    _pageManager.loadingIsProgress = false;
    notifyListeners();
  }

  void _updateValues(MovieListResponse response) {
    _movies.addAll(response.movies);
    _pageManager.totalPage = response.totalPages;
    _pageManager.incrementCurrentPage();
  }
}