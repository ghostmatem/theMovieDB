import 'package:flutter/material.dart';
import 'package:the_movie_db/user_interface/secondary_widgets/my_placer.dart';
import 'package:the_movie_db/user_interface/styles/movie_list_screen_theme.dart';

class MovieListTitle extends StatelessWidget {
  const MovieListTitle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = _borderRadius();

    return Ink(
      decoration: _boxDecoration(),
      width: double.infinity,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () { },
        child: ClipRRect(
          borderRadius: borderRadius,
          clipBehavior: Clip.hardEdge,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Placeholder(fallbackHeight: 141, fallbackWidth: 94),
              Expanded(child: _MovieDescriptionWidget())
          ]),
        ),
      ),
    ); 
  }

  BoxDecoration _boxDecoration() {
    final boxDecoration = BoxDecoration(
      borderRadius: _borderRadius(),
      border: Border.all(
        width: 0.09
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
        color: Colors.blueGrey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(1, 1))
      ]
    );
    return boxDecoration;
  }

  BorderRadius _borderRadius() => BorderRadius.circular(8);
}

class _MovieDescriptionWidget extends StatelessWidget {
  const _MovieDescriptionWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14, 
          vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Человек-паук: Нет пути домой", 
              style: MovieListScreenTheme.headerTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
            MyPlacer(height: 5),
            Text(
              "15 декабря 2021",
              style: MovieListScreenTheme.dateTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
            MyPlacer(height: 15),
            Text(
              "Действие фильма «Человек-паук: Нет пути домой» начинает своё развитие в тот момент, когда Мистерио удаётся выяснить истинную личность Человека-паука. С этого момента жизнь Питера Паркера становится невыносимой. Если ранее он мог успешно переключаться между своими амплуа, то сейчас это сделать невозможно. Переворачивается с ног на голову не только жизнь Человека-пауку, но и репутация.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: MovieListScreenTheme.descriptionTextStyle)
          ],
        ),
      );
  }
}