import 'package:the_movie_db/data/entity/movie_view_category/category_data.dart';
import 'package:the_movie_db/data/entity/movie_view_category/movie_view_category.dart';

abstract class CategoryRote {

  static CategoryData getDataByCategory(MovieViewCategory category) => _callMap[category]!;

  static final Map<MovieViewCategory, CategoryData> _callMap = <MovieViewCategory, CategoryData> {
      MovieViewCategory.nowPlaying  :  CategoryData('Смотрят сейчас',     '/movie/now_playing'),
      MovieViewCategory.popular     :  CategoryData('Популярные фильмы',  '/movie/popular'),
      MovieViewCategory.topRated    :  CategoryData('Лучшие фильмы',      '/movie/top_rated'),
      MovieViewCategory.upcoming    :  CategoryData('Ожидаемые фильмы',   '/movie/upcoming'),
    };
}