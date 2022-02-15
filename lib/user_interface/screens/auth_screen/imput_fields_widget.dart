import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/providers.dart';
import 'package:the_movie_db/data/models/auth_model.dart';
import 'package:the_movie_db/user_interface/navigation/app_routes.dart';
import 'package:the_movie_db/user_interface/styles/auth_theme.dart';
import 'package:the_movie_db/user_interface/widgets/my_placer.dart';
import 'package:the_movie_db/user_interface/widgets/my_text_field_widget.dart';

class ImputFieldsWidget extends StatelessWidget {
  const ImputFieldsWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context)!;
    return Column(
      children: [
        const _AuthErrorWidget(),
        MyTextFieldWidget(
          labelText: 'Логин', 
          controller: model.loginController),
        MyPlacer(height: AuthTheme.insets.afterLoginField),
        MyTextFieldWidget(
          labelText: 'Пароль', 
          controller: model.passwordController,
          hideText: true),
        MyPlacer(height: AuthTheme.insets.afterPasswordField),
        const SizedBox(
          width: double.infinity,
          child: _AuthRequestButton()),
        MyPlacer(height: AuthTheme.insets.afterLoginButton), 
        const _SecondActionWidget(),  
      ],
    );
  }
}

class _AuthRequestButton extends StatelessWidget {
  const _AuthRequestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canSendAuthRequest = NotifierProvider.watch<AuthModel>(context)!.canSendAuthRequest;
    return ElevatedButton(
      onPressed: canSendAuthRequest ? () => _auth(context) : null, 
      child: const FittedBox(child:Text("Войти")),
      style: AuthTheme.mainButtonStyle);
  }

  Future<void> _auth(BuildContext context) async {
    final model = NotifierProvider.read<AuthModel>(context)!;
    await model.logIn();
    if (model.errorMessage.isNotEmpty) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.mainScreen);
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

class _AuthErrorWidget extends StatelessWidget {
  const _AuthErrorWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthModel>(context)!.errorMessage;
    return errorMessage.isEmpty
    ? const SizedBox.shrink()
    : SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '* '+ errorMessage, 
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16)),
          MyPlacer(height: AuthTheme.insets.afterLabelText)
        ],
      ),
    );
  }
}

