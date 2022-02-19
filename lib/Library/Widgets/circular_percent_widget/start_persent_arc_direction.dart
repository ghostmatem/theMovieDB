import 'dart:math';

enum StartPersentArcDirection {
  top,
  right,
  left,
  bottom
}

abstract class StartPersentArcDirectionRote {

  static getRadianAngleAtDirection(StartPersentArcDirection direction) =>
    _directionMap[direction]!;

  static const _directionMap = <StartPersentArcDirection, double> {
  StartPersentArcDirection.top : -pi/2,
  StartPersentArcDirection.right : 0,
  StartPersentArcDirection.left : -pi,
  StartPersentArcDirection.bottom : pi/2,
  };
}