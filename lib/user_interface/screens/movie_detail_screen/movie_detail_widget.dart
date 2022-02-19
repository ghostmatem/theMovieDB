import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Math/correction_functions.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/behavior_unvaried_parametr/behavior_unvaried_parametr.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/circular_percent_color.dart';
import 'package:the_movie_db/Library/Widgets/circular_percent_widget/start_persent_arc_direction.dart';
import 'package:the_movie_db/user_interface/screens/movie_detail_screen/movie_db_rating_widget.dart';
import 'package:the_movie_db/user_interface/styles/app_theme.dart';
import '../../../Library/Widgets/circular_percent_widget/cirlular_percent_widget.dart';


class MovieDetailWidget extends StatelessWidget {
  const MovieDetailWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Челопук'),
        centerTitle: true),
      body: const Center(
        child: MovieDBRatingWidget(
          percent: 0.12,
          width: 300,
          height: 300),
      ),
    );
  }

  
}


