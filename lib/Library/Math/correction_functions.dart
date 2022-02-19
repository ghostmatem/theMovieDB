import 'dart:math';

double getCorrectedOfPositiveModule(double value, double limit) => value % limit;

double getCorrectedNegativeModule(double value, double limit) {
  if (value >= 0) return value;
  final periodAmount = value*-1 ~/ limit + 1;
  return (limit * periodAmount + value) % limit;
}

double getLimitedOnRange(double value, double minimum, double maximum) {
  return max(minimum, min(value, maximum));
}

double getLimitedTop(double value, double limit) => min(value, limit);
double getLimitedBottom(double value, double limit) => max(value, limit);