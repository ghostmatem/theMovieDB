import 'package:flutter/material.dart';

class MyPlacer extends StatelessWidget {
  const MyPlacer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
