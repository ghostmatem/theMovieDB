import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/styles/auth_theme.dart';

class MyTextFieldWidget extends StatelessWidget {
  const MyTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    this.hideText = false,
  }) : super(key: key);

  final String labelText;
  final bool hideText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hideText,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,       
        border: const OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(
            Radius.circular(AuthTheme.borderRadius))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12)
        ),
      );   
  }
}
