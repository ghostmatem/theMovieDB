import 'package:flutter/material.dart';

import 'app_theme.dart';

abstract class MovieListScreenTheme {

  static const double posterHeight = 141;
  static const double posterWidth = 94;

  static final logoPlaceholred = Image.asset(AppTheme.logo, scale: 3);

  static const headerTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700
  );

  static const dateTextStyle = TextStyle(
    fontSize: 14.4,
    color: Color(0xFF999999)
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 14.4,
  );
}