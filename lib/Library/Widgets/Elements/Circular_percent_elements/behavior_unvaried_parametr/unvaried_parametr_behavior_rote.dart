import 'behavior_unvaried_parametr.dart';

abstract class UnvariedParametrBehaviorRote {

  static double Function(double a, double b) getBehaviorFunction(BehaviorUnvariedParametr behavior) => 
  _behaviorMap[behavior]!;

  static final _behaviorMap  = <BehaviorUnvariedParametr, double Function(double a, double b)> {
    BehaviorUnvariedParametr.minValue : (double min, double max) => min,
    BehaviorUnvariedParametr.maxValue : (double min, double max) => max,
    BehaviorUnvariedParametr.avarage : (double min, double max) => (min + max) / 2 
  };
}