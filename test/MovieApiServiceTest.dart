import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:task/mocks/mocks.dart';
import 'package:task/models/Movie.dart';
import 'package:task/network/MovieApiService.dart';

void main() {
  final api_key = 'ab852022baac8256ea5738cd1b69fe1b';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  final MockClient client = MockClient();
  final MovieApiService svc = MovieApiService()..client = client;

  test('Returns a list of Movies if request is successful', () async {
    when(client.get('$_baseUrl/now_playing?api_key=$api_key')).thenAnswer(
      (_) async => http.Response('''
{"results":[{"popularity":126.47,"vote_count":13,"video":false,"poster_path":"\/1Duc3EBiegywczxTWekvy03HWai.jpg","id":554993,"adult":false,"backdrop_path":"\/oCFbh4Mrd0fuGanCgIF6sG27WGD.jpg","original_language":"sv","original_title":"Britt-Marie var här","genre_ids":[35,18],"title":"Britt-Marie Was Here","vote_average":5.2,"overview":"Britt-Marie, a woman in her sixties, decides to leave her husband and start anew. Having been housewife for most of her life and and living in small backwater town of Borg, there isnt many jobs available and soon she finds herself fending a youth football team.","release_date":"2019-01-25"}],"page":1,"total_results":569,"dates":{"maximum":"2020-06-30","minimum":"2020-05-13"},"total_pages":29}''',
          200),
    );

    expect(await svc.getNowPlayingMovies(), isInstanceOf<List<Movie>>());
  });
}
