import 'package:flutter/material.dart';
import 'package:the_movie_db/data/entity/card_movie.dart';
import 'package:the_movie_db/user_interface/styles/app_theme.dart';
import 'package:the_movie_db/user_interface/styles/movie_list_screen_theme.dart';
import 'package:the_movie_db/Library/Extentions/date_time_extention.dart';

import '../../../Library/Widgets/my_placer.dart';


class MovieListTitleWidget extends StatelessWidget {
  const MovieListTitleWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final CardMovie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MovieListScreenTheme.posterHeight,
      child: Stack(
        children: [
          _movieWidget(),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: _borderRadius(),
              onTap: (){},
            ))
        ],
      ),
    );
  }

  Widget _movieWidget() {
    return Container(
      width: double.infinity,
      decoration: _boxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageWidget(movie.posterPath),
          Expanded(child: _MovieDescriptionWidget(
            title: movie.title,
            releaseDate: movie.releaseDate,
            overview: movie.overview,
          ))
      ]),
    ); 
  }

  Widget _imageWidget(String? posterPath) {
    return SizedBox(
      height: MovieListScreenTheme.posterHeight,
      width: MovieListScreenTheme.posterWidth,
      child: posterPath != null
      ? FadeInImage.assetNetwork(
        placeholder: AppTheme.logo,
        placeholderScale: 3,
        image: posterPath)
      : MovieListScreenTheme.logoPlaceholred,
    );
  }

  BoxDecoration _boxDecoration() {
    final boxDecoration = BoxDecoration(
      borderRadius: _borderRadius(),
      border: Border.all(
        width: 0.09
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
        color: Colors.blueGrey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(1, 1))
      ]
    );
    return boxDecoration;
  }

  BorderRadius _borderRadius() => BorderRadius.circular(8);
}

class _MovieDescriptionWidget extends StatelessWidget {
  const _MovieDescriptionWidget({
    Key? key,
    required this.title,
    required this.releaseDate,
    required this.overview,
  }) : super(key: key);

  final String title;
  final DateTime? releaseDate;
  final String overview;

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14, 
          vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: MovieListScreenTheme.headerTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
            const MyPlacer(height: 5),
            Text(
              releaseDate?.toStringFormat() ?? '',
              style: MovieListScreenTheme.dateTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
            const MyPlacer(height: 12),
            Expanded(
              child: Text(
                overview,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: MovieListScreenTheme.descriptionTextStyle),
            )
          ],
        ),
      );
  }
}
