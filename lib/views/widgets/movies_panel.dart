import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:task/models/Movie.dart';
import 'package:task/view_models/MainPageViewModel.dart';
import 'package:task/views/widgets/movie_list_item.dart';
import 'package:task/views/widgets/no_internet_connection.dart';

class FilmsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<Movie>>(
          future: model.movies,
          builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: const CircularProgressIndicator());              
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var films = snapshot.data;
                  return ListView.builder(
                    itemCount: films == null ? 0 : films.length,
                    itemBuilder: (_, int index) {
                      var film = films[index];
                      return MoviesListItem(movie: film);
                    },
                  );
                } else if (snapshot.hasError) {
                  return NoInternetConnection(
                    action: () async {
                      await model.getNowPlayingMovies();
                    },
                  );
                }
            }
          },
        );
      },
    );
  }
}