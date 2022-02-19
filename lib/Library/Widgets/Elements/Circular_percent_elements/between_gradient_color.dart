import 'package:flutter/material.dart';

import 'package:the_movie_db/Library/Math/correction_functions.dart' as correct;

import 'behavior_unvaried_parametr/behavior_unvaried_parametr.dart';
import 'behavior_unvaried_parametr/unvaried_parametr_behavior_rote.dart';
import 'circular_percent_color.dart';

class BetweenGradientColor implements CircularPercentColor {
  final bool isRangeBetween;
  late final HSVColor minGradientColor;
  late final HSVColor maxGradientColor; 
  late final bool _varySaturation;
  late final bool _varyValue;
  late final bool _varyAlpha;
  late final bool _clipPercent;

  BetweenGradientColor({
    required Color minGradientColor,
    required Color maxGradientColor,
    this.isRangeBetween = true,
    bool varySaturation = true,
    bool varyValue = true,
    bool varyAlpha = false,
    bool clipPercent = true,
    BehaviorUnvariedParametr behavior = BehaviorUnvariedParametr.avarage,
  }) {
    this.minGradientColor = HSVColor.fromColor(minGradientColor);
    this.maxGradientColor = HSVColor.fromColor(maxGradientColor);
    _behaviorFunction = UnvariedParametrBehaviorRote.getBehaviorFunction(behavior);
    _varySaturation = varySaturation;
    _varyValue = varyValue;
    _varyAlpha = varyAlpha;
    _clipPercent = clipPercent;
  }

  @override
  Color getColorAtPercent(double percent) {
    return _calculateColorBetweenAtPercent(percent);
  }

  Color _calculateColorBetweenAtPercent(double percent) {
    if (_clipPercent) percent = correct.getLimitedOnRange(percent, 0.0, 1.0);
    
    final ceilPercent = (percent * 100) ~/ 1;
    final alpha = _calculateAlpha(ceilPercent);
    final hue = _calculateHue(ceilPercent);
    final saturation = _calculateSaturation(ceilPercent);
    final value = _calculateValue(ceilPercent);
    
    return HSVColor.fromAHSV(
      alpha, 
      hue, 
      saturation, 
      value).toColor();
  }

  late final double Function(double a, double b) _behaviorFunction;

  double _calculateHue(int percent) {
    return _calculateParametr(minGradientColor.hue, maxGradientColor.hue, percent, 360.0);
  }

  double _calculateSaturation(int percent) {
    return _varySaturation 
    ? _calculateParametr(minGradientColor.saturation, maxGradientColor.saturation, percent, 1.0)
    : _behaviorFunction(minGradientColor.saturation, maxGradientColor.saturation);
  }

  double _calculateValue(int percent) {
    return _varyValue
    ? _calculateParametr(minGradientColor.value, maxGradientColor.value, percent, 1.0)
    : _behaviorFunction(minGradientColor.value, maxGradientColor.value);
  }

  double _calculateAlpha(int percent) {
    return _varyAlpha 
    ? _calculateParametr(minGradientColor.alpha, maxGradientColor.alpha, percent, 1.0)
    : _behaviorFunction(minGradientColor.alpha, maxGradientColor.alpha);
  }

  double _calculateParametr(double min, double max, int percent, double limit) {
    final intervalLength = (max - min).abs();
    final onePercent = isRangeBetween ? intervalLength / 100 : (limit - intervalLength) / 100;

    final increasedMinimum = _correction(min + onePercent * percent, limit);
    final reducedMinimum = _correction(min - onePercent * percent, limit);

    if (isRangeBetween) {
      return max > min ? increasedMinimum : reducedMinimum;
    }
    return max > min ? reducedMinimum : increasedMinimum;
  }

  double _correction(double value, double limit) {
    return value.isNegative 
    ? correct.getCorrectedNegativeModule(value, limit)
    : correct.getCorrectedOfPositiveModule(value, limit);
  }
}
