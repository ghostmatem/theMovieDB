import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/auth_screen/imput_fields_widget.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_placer.dart';
import 'package:the_movie_db/user_interface/styles/auth_theme.dart';

class AuthMainWidget extends StatelessWidget {
  const AuthMainWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthTheme.backColor,
      appBar: AppBar(
        title: const Text("Авторизация"),
        centerTitle: true,
      ),
      body: const _AuthBody(),
    );
  }
}

class _AuthBody extends StatelessWidget {
  const _AuthBody({ 
    Key? key, 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    const labelText = 'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. \nЕсли у вас нет учётной записи, её регистрация является простой и бесплатной.';

    return SingleChildScrollView(
      padding: AuthTheme.insets.authScreenPadding,
      child: Column(
        children: [
          const Text(
            labelText,
            style: AuthTheme.labelTextStyle),
          MyPlacer(height: AuthTheme.insets.afterLabelText),
          const ImputFieldsWidget()
        ],),
    );
  }
}

