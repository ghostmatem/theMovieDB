import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/auth_screen/auth_main_widget.dart';
import 'package:the_movie_db/user_interface/popular_movie_screen/popular_movie_main_widget.dart';

import 'app_routes.dart';


class MainAppNavigations {

  final String initialRoute = AppRoutes.mainScreen;

  final routes = <String, Widget Function(BuildContext)>{

    AppRoutes.auth : (context) => const AuthMainWidget(),
    AppRoutes.mainScreen : (context) => const PopularMovieMainWidget(),
  };
  
}