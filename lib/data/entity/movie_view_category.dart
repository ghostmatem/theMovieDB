enum MovieViewCategory {
  nowPlaying,
  popular,
  topRated,
  upcoming
}

abstract class CategoryRoot {

  static CategoryData getDataByCategory(MovieViewCategory category) => _callMap[category]!;

  static final Map<MovieViewCategory, CategoryData> _callMap = <MovieViewCategory, CategoryData> {
      MovieViewCategory.nowPlaying  :  CategoryData('Смотрят сейчас',     '/movie/now_playing'),
      MovieViewCategory.popular     :  CategoryData('Популярные фильмы',  '/movie/popular'),
      MovieViewCategory.topRated    :  CategoryData('Лучшие фильмы',      '/movie/top_rated'),
      MovieViewCategory.upcoming    :  CategoryData('Ожидаемые фильмы',   '/movie/upcoming'),
    };
}

class CategoryData {
  final String header;
  final String urlPath;

  CategoryData(
    this.header,
    this.urlPath,
  );
}