import 'dart:async';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:task/models/Movie.dart';
import 'package:task/network/IMovieApi.dart';

class MainPageViewModel extends Model {
  Future<List<Movie>> _movies;
  Future<List<Movie>> get movies => _movies;
  set movies(Future<List<Movie>> value) {
    _movies = value;
    notifyListeners();
  }

  final IMovieApi apiSvc;

  MainPageViewModel({@required this.apiSvc});

  Future<bool> getNowPlayingMovies() async {
    movies = apiSvc?.getNowPlayingMovies();
    return movies != null;
  }


}