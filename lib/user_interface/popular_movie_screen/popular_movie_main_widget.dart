import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/movie_view_screen_widget/movie_view_screen_widget.dart';



class PopularMovieMainWidget extends StatelessWidget {
  const PopularMovieMainWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MovieViewScreenWidget(
      header: 'Популярные фильмы',
    );
  }
}