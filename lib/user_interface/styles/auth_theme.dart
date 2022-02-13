import 'package:flutter/material.dart';

abstract class AuthTheme {

  static const Color buttonColor = Color(0xFF01b4e4);
  static const Color backAppBarColor = Color(0xFA0d253f);

  static const Color backColor = Color.fromRGBO(255, 255, 255, 0.95); 

  static const borderRadius = 6.0;

  static const insets = AuthInsets._();

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 16.5,
  );

  static final ButtonStyle mainButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(buttonColor),
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
        color: buttonColor,
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
