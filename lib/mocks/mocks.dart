import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:task/network/ITaskApi.dart';

class MockClient extends Mock implements http.Client {}
class MockTaskRepository extends Mock implements ITaskAPi {}