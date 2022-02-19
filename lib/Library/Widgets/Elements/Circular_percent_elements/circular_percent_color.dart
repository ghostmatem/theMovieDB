import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/between_gradient_color.dart';

import 'behavior_unvaried_parametr/behavior_unvaried_parametr.dart';

abstract class CircularPercentColor {

  Color getColorAtPercent(double percent);

  factory CircularPercentColor.simpleColor(Color color) {
    return SimpleColor(color: color);
  }
  

  factory CircularPercentColor.betweenGradientColor({
    required Color minGradientColor,
    required Color maxGradientColor,
    bool isRangeBetween = true,
    bool varySaturation = true,
    bool varyValue = true,
    bool varyAlpha = false,
    bool clipPercent = true,
    BehaviorUnvariedParametr behavior = BehaviorUnvariedParametr.avarage,
  }) {
    return BetweenGradientColor(
      minGradientColor : minGradientColor,
      maxGradientColor : maxGradientColor,
      isRangeBetween : isRangeBetween,
      varySaturation : varySaturation,
      varyValue : varyValue,
      varyAlpha : varyAlpha,
      clipPercent : clipPercent,
      behavior : behavior
    );
  }
}


class SimpleColor implements CircularPercentColor {

  late final Color _color;
  SimpleColor({
    required Color color
  }) {
    _color = color;
  }

  @override
  Color getColorAtPercent(double percent) => _color;
}
