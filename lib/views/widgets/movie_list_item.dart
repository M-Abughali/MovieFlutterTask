import 'package:flutter/material.dart';
import 'package:task/models/Movie.dart';
import 'package:task/utils/MovieStyles.dart';

class MoviesListItem extends StatelessWidget {
  final Movie movie;

  MoviesListItem({@required this.movie});

  @override
  Widget build(BuildContext context) {
    var title = Text(
      movie?.title,
      style: TextStyle(
        color: MovieStyles.titleColor,
        fontWeight: FontWeight.bold,
        fontSize: MovieStyles.titleFontSize,
      ),
    );

    var subTitle = Row(
      children: <Widget>[
        Icon(
          Icons.movie,
          color: MovieStyles.subTitleColor,
          size: MovieStyles.subTitleFontSize,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4.0),
          child: Text(
            movie?.id.toString(),
            style: TextStyle(
              color: MovieStyles.subTitleColor,
            ),
          ),
        ),
      ],
    );

    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: title,
          subtitle: subTitle,
        ),
        Divider(),
      ],
    );
  }
}