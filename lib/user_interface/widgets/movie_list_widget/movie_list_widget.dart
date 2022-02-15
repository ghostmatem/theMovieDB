import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/providers.dart';
import 'package:the_movie_db/data/models/movie_model.dart';
import 'package:the_movie_db/user_interface/styles/app_theme.dart';

import 'movie_list_title_widget.dart';


class MovieListWidget extends StatelessWidget {
  const MovieListWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieModel>(context)!;

    if (!model.hasData) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primaryColor
        ));
    }

    final movies = model.movies!;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        model.autoUploadingMoviesByIndex(index);
        return MovieListTitleWidget(movie : movies[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 24);
      },
    );
  }
}