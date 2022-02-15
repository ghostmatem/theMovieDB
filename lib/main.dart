import 'package:flutter/material.dart';
import 'package:the_movie_db/data/models/app_model.dart';
import 'package:the_movie_db/user_interface/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppModel.initInstanse();
  runApp(const MyApp());
}

