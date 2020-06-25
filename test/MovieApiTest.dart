import 'package:flutter_test/flutter_test.dart';
import 'package:task/models/Movie.dart';
import 'package:task/network/IMovieApi.dart';
import 'package:task/network/MovieApiService.dart';

void main() {
  final IMovieApi svc = MovieApiService();

  test(
    'get Now Playing Movies GET request test',
    () async {
      expect(await svc.getNowPlayingMovies(), isInstanceOf<List<Movie>>());
    },
  );


}