import 'dart:async';

import 'package:task/models/Movie.dart';

abstract class IMovieApi {
  Future<List<Movie>> getNowPlayingMovies();
}