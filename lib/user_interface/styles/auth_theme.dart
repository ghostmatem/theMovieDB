import 'package:flutter/material.dart';

import 'app_theme.dart';

abstract class AuthTheme {

  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 0.95); 

  static const borderRadius = 6.0;

  static const insets = AuthInsets._();

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16.5,
  );

  static final ButtonStyle mainButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppTheme.secondaryColor),
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      )
    ),
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600
      ))
  );

  static final ButtonStyle secondButtonStyle = ButtonStyle(
 
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      )
    ),
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        color: AppTheme.secondaryColor,
      ))
  );
}

class AuthInsets {
  const AuthInsets._();

  final EdgeInsets authScreenPadding = const EdgeInsets.all(16);

  final double afterLabelText = 20;
  final double afterLoginField = 15;
  final double afterPasswordField = 15;
  final double afterLoginButton = 5;
  final double betweenSecondButtons = 10;
}
