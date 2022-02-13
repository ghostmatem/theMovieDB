import 'package:flutter/material.dart';

import 'movie_list_title.dart';


class MovieListView extends StatelessWidget {
  const MovieListView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return const MovieListTitle();
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 24);
      },
    );
  }
}