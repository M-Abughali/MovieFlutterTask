import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/models/Movie.dart';
import 'package:task/models/MovieResult.dart';
import 'package:task/network/IMovieApi.dart';

class MovieApiService implements IMovieApi {
  final api_key = 'ab852022baac8256ea5738cd1b69fe1b';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  http.Client _client = http.Client();

  set client(http.Client value) => _client = value;

  static final MovieApiService _internal = MovieApiService.internal();
  factory MovieApiService() => _internal;
  MovieApiService.internal();

  Future<List<Movie>> getNowPlayingMovies() async {
    var response = await _client.get('$_baseUrl/now_playing?api_key=$api_key');

    print(response.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      MovieResult movieResult = MovieResult.fromJson(data);
      return movieResult.results;
    } else {
      throw Exception('Failed to get data');
    }
  }
}
