import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/Elements/Circular_percent_elements/circular_percent_color.dart';

import 'package:the_movie_db/Library/Widgets/circular_percent_widget/start_persent_arc_direction.dart';

import 'arc_position.dart';

class CircularPercentIndicatorWidget extends StatelessWidget {
  const CircularPercentIndicatorWidget({
    Key? key,
    required this.percent,  
    required this.backgroundColor,
    required this.emptyArcColor,
    required this.mainArcColor,
    required this.mainArcPosition,
    required this.emptyArcPosition,
    this.child,
    this.width,
    this.height,
    this.startDirection = StartPersentArcDirection.top,
    this.isClockwiseMoment = true,
  }) : super(key: key);
  
  final double percent;
  final Widget? child;
  final double? width;
  final double? height;
  final CircularPercentColor backgroundColor;
  final CircularPercentColor emptyArcColor;
  final CircularPercentColor mainArcColor;
  final ArcPosition mainArcPosition;
  final ArcPosition emptyArcPosition;
  final StartPersentArcDirection startDirection;
  final bool isClockwiseMoment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        child: child,
        painter: _CircularPercentPainter(
          startPersentArcDirection: startDirection,
          percent: percent, 
          backgroundColor: backgroundColor, 
          emptyArcColor: emptyArcColor, 
          mainArcColor: mainArcColor, 
          emptyArcPosition: emptyArcPosition, 
          mainArcPosition: mainArcPosition,
          isClockwiseMoment: isClockwiseMoment   
        ),
    ));
  }
}

class _CircularPercentPainter extends CustomPainter {

  final double percent;
  final CircularPercentColor backgroundColor;
  final CircularPercentColor emptyArcColor;
  final CircularPercentColor mainArcColor;
  final ArcPosition mainArcPosition;
  final ArcPosition emptyArcPosition;
  final StartPersentArcDirection startPersentArcDirection;
  final bool isClockwiseMoment;

  _CircularPercentPainter({
    required this.percent,
    required this.backgroundColor,
    required this.emptyArcColor,
    required this.mainArcColor,
    required this.mainArcPosition,
    required this.emptyArcPosition,
    required this.startPersentArcDirection,
    required this.isClockwiseMoment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawEntryArc(canvas, size);
    _drawMainArc(canvas, size);
  }

  void _drawEntryArc(Canvas canvas, Size size) {
    _drawArc(
      canvas: canvas,
      parentSize: size,
      color: emptyArcColor.getColorAtPercent(percent),
      arcOffset: emptyArcPosition.offset,
      strokeWidth: emptyArcPosition.strokeWidth,
      startAngle: 0,
      sweepAngle: pi * 2
    );
  }

   void _drawMainArc(Canvas canvas, Size size) {
    final sweepAngle = pi * 2 * percent;
    _drawArc(
      canvas: canvas,
      parentSize: size,
      color: mainArcColor.getColorAtPercent(percent),
      arcOffset: mainArcPosition.offset,
      strokeWidth: mainArcPosition.strokeWidth,
      startAngle: StartPersentArcDirectionRote
      .getRadianAngleAtDirection(startPersentArcDirection),
      sweepAngle: isClockwiseMoment ? sweepAngle : -sweepAngle
    );
  }

  void _drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = backgroundColor.getColorAtPercent(percent);
    canvas.drawOval(Offset.zero & size, paint);
  }

  void _drawArc({
    required Canvas canvas, 
    required Size parentSize,
    required Color color,
    required Offset arcOffset,
    required double strokeWidth,
    required double startAngle,
    required double sweepAngle,
    }) {
    final arcWidth = parentSize.width - arcOffset.dx * 2 - strokeWidth;
    final arcHeight = parentSize.height - arcOffset.dy * 2 - strokeWidth;

    final paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      Offset(arcOffset.dx + strokeWidth/2, arcOffset.dy + strokeWidth/2) 
      & Size(arcWidth, arcHeight), 
      startAngle, 
      sweepAngle, 
      false, 
      paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
