import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/navigation/main_navigations.dart';
import 'package:the_movie_db/user_interface/styles/auth_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainAppNavigations = MainAppNavigations();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: AuthTheme.backAppBarColor)
      ),
      routes: mainAppNavigations.routes,
      initialRoute: mainAppNavigations.initialRoute,
    );
  }
}