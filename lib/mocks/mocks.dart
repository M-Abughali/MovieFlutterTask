import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:task/network/IMovieApi.dart';

class MockClient extends Mock implements http.Client {}
class MockSwapiService extends Mock implements IMovieApi {}