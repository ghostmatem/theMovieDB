import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_text_field_widget.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_placer.dart';
import 'package:the_movie_db/user_interface/styles/auth_theme.dart';

class ImputFieldsWidget extends StatefulWidget {
  const ImputFieldsWidget({ Key? key }) : super(key: key);

  @override
  _ImputFieldsWidgetState createState() => _ImputFieldsWidgetState();
}

class _ImputFieldsWidgetState extends State<ImputFieldsWidget> {

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFieldWidget(
          labelText: 'Логин', 
          controller: loginController),
        MyPlacer(height: AuthTheme.insets.afterLoginField),
        MyTextFieldWidget(
          labelText: 'Пароль', 
          controller: passwordController,
          hideText: true),
        MyPlacer(height: AuthTheme.insets.afterPasswordField),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _auth, 
            child: const FittedBox(child:Text("Войти")),
            style: AuthTheme.mainButtonStyle)),
        MyPlacer(height: AuthTheme.insets.afterLoginButton), 
        const _SecondActionWidget(),  
      ],
    );
  }

  void _auth() {
  }

}

class _SecondActionWidget extends StatelessWidget {
  const _SecondActionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _forgetPass, 
            child: const FittedBox(child:Text("Сбросить пароль")), 
            style: AuthTheme.secondButtonStyle),
        ),
        MyPlacer(width: AuthTheme.insets.betweenSecondButtons),
        Expanded(
          child: OutlinedButton(
            onPressed: _register, 
            child: const FittedBox(child: Text("Зарегистрироваться")),
            style: AuthTheme.secondButtonStyle)
        ),
      ]);
  }

  void _forgetPass() {
  }

  void _register() {
  }
}