import 'package:flutter/material.dart';

import 'package:the_movie_db/user_interface/movie_list_view_widget/movie_list_view.dart';
import 'package:the_movie_db/user_interface/movie_view_screen_widget/movie_search_delegate.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_placer.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_text_field_widget.dart';

class MovieViewScreenWidget extends StatelessWidget {
  const MovieViewScreenWidget({
    Key? key,
    required this.header,
  }) : super(key: key);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(header),
        centerTitle: true,
        actions: [
          _searchButton(context)
        ],),
      body: const MovieListView(),
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