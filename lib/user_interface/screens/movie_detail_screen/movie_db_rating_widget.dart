import 'package:flutter/material.dart';

import 'package:the_movie_db/Library/Math/correction_functions.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/behavior_unvaried_parametr/behavior_unvaried_parametr.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/circular_percent_color.dart';
import 'package:the_movie_db/Library/Widgets/circular_percent_widget/cirlular_percent_widget.dart';
import 'package:the_movie_db/user_interface/styles/app_theme.dart';

class MovieDBRatingWidget extends StatelessWidget {
  const MovieDBRatingWidget({
    Key? key,
    required this.percent,
    this.width,
    this.height,
  }) : super(key: key);

  final double percent;
  final double? width;
  final double? height;
  

  @override
  Widget build(BuildContext context) {
    final viewPercentText = getLimitedOnRange(percent*100, 0, 100)~/1;
    return CircularPercentWidget(
      percent: percent,
      viewPercentText: '$viewPercentText%',
      backgroundColor: CircularPercentColor.simpleColor(
        AppTheme.primaryColor),
      emptyArcColor: viewPercentText > 0 
      ?_emptyArcColor() 
      : CircularPercentColor.simpleColor(const Color(0xBB888888)),
      mainArcColor: _mainArcColor(),
      width: width,
      height: height,
    );
  }

  CircularPercentColor _mainArcColor() {
    return CircularPercentColor.betweenGradientColor(
      minGradientColor: const Color(0xFFd03521), 
      maxGradientColor: const Color(0xFF21d084)
    );
  }

  CircularPercentColor _emptyArcColor() {
    return CircularPercentColor.betweenGradientColor(
      minGradientColor: const Color(0xAA962c18),
      maxGradientColor: const Color(0xAA1aa36f),
      behavior: BehaviorUnvariedParametr.minValue
    );
  }
}
