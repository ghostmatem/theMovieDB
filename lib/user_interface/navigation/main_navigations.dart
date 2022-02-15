import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/providers.dart';
import 'package:the_movie_db/data/models/app_model.dart';
import 'package:the_movie_db/data/models/movie_model.dart';
import 'package:the_movie_db/user_interface/screens/auth_screen/auth_main_widget.dart';
import 'package:the_movie_db/user_interface/screens/movie_view_screen/movie_view_screen_widget.dart';

import 'app_routes.dart';


class MainAppNavigations {

  final String initialRoute = 
  AppModel.instanse.isLoggedIn
  ? AppRoutes.mainScreen
  : AppRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{

    AppRoutes.auth : (context) => const AuthMainWidget(),
    AppRoutes.mainScreen : _showMovieWidget,
  };

  static Widget _showMovieWidget(BuildContext context) {
    final model = 
    ModalRoute.of(context)!
    .settings.arguments as MovieModel? ?? MovieModel();

    model.setup();
    
    return NotifierProvider(
      child: 
      const MovieViewScreenWidget(), 
      model: model);
  }
}