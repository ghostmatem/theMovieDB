import 'package:flutter/material.dart';
import 'package:the_movie_db/Library/Widgets/providers.dart';
import 'package:the_movie_db/data/models/movie_model.dart';
import 'package:the_movie_db/user_interface/widgets/movie_list_widget/movie_list_widget.dart';


import 'movie_search_delegate.dart';



class MovieViewScreenWidget extends StatelessWidget {
  const MovieViewScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const _HeaderWidget(),
        centerTitle: true,
        actions: [
          _searchButton(context)
        ],),
      body: const MovieListWidget(),
    );
  }

  Future<void> _search(BuildContext context) async {
    await showSearch(
      context: context, 
      delegate: MovieSearchDelegate());
  }

  _searchButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        iconSize: 28,
        onPressed: () =>_search(context), 
        icon: const Icon(Icons.search)),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieModel>(context)!;
    return Text(model.screenHeader);
  }
}