import 'dart:math';

import 'package:flutter/material.dart';

import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/circular_percent_color.dart';
import 'package:the_movie_db/Library/Widgets/circular_percent_widget/arc_position.dart';
import 'package:the_movie_db/Library/Widgets/circular_percent_widget/circular_percent_indicator_widget.dart';
import 'package:the_movie_db/Library/Widgets/circular_percent_widget/start_persent_arc_direction.dart';

class CircularPercentWidget extends StatelessWidget {
  const CircularPercentWidget({
    Key? key,
    required this.percent,
    required this.viewPercentText,
    required this.backgroundColor,
    required this.emptyArcColor,
    required this.mainArcColor,
    this.width,
    this.height,
    this.textStyle,
    this.fontColor,
    this.defaultFontSize = 29, 
    this.oneHandredPercentScaleFactor = 0.85, 
    this.arcOffset = 5.8,
    this.strokeArcWidth = 6.36,  
    this.startDirection = StartPersentArcDirection.top,
    this.isClockwiseMoment = true,
  }) : super(key: key);

  final double percent;
  
  final double? width;
  final double? height;

  final double defaultFontSize;
  final CircularPercentColor? fontColor;
  final TextStyle? textStyle;
  final double oneHandredPercentScaleFactor;

  final double arcOffset;
  final double strokeArcWidth;

  final CircularPercentColor backgroundColor;
  final CircularPercentColor emptyArcColor;
  final CircularPercentColor mainArcColor;
  final StartPersentArcDirection startDirection;
  final bool isClockwiseMoment;

  final String viewPercentText;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double baseRadius = 100;

    final _width = width ?? size.width;
    final _height = height ?? size.height;

    final widthScaleFactor = _width / baseRadius;
    final heightScaleFactor = _height / baseRadius;

    final complexScaleFactor = 
      sqrt((_width * _height * pi)) 
      / sqrt((baseRadius * baseRadius * pi)
    );

    final style = textStyle ?? _defaultTextStyle();
    
    final arcPosition = ArcPosition(
        offset: Offset(arcOffset * widthScaleFactor, arcOffset * heightScaleFactor), 
        strokeWidth: strokeArcWidth * complexScaleFactor
    );

    return CircularPercentIndicatorWidget(
      percent: percent,
      backgroundColor: backgroundColor,
      emptyArcColor: emptyArcColor,
      mainArcColor: mainArcColor,
      mainArcPosition: arcPosition,
      emptyArcPosition: arcPosition,
      child: Center(
        child: Text(
          viewPercentText, 
          style: style,
          textScaleFactor: _textScaleFactor(widthScaleFactor))),
      width: width,
      height: height,
      startDirection: startDirection,
      isClockwiseMoment: isClockwiseMoment,
    );
  }

  TextStyle _defaultTextStyle() {
    return TextStyle(
    fontSize: defaultFontSize,
    color: fontColor
    ?.getColorAtPercent(percent) ?? Colors.white,

    fontWeight: FontWeight.bold,
    fontFamily: 'Source Sans Pro'
    );
  }

  double _textScaleFactor(double widthScaleFactor) {
    return percent ~/ 1 == 0 
    ? widthScaleFactor
    : widthScaleFactor * oneHandredPercentScaleFactor;
  }
}
