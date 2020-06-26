import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:task/mocks/mocks.dart';
import 'package:task/models/Task.dart';
import 'package:task/network/TaskRepository.dart';
import 'package:task/network/NetworkConstants.dart';
import 'package:task/view_models/TasksListViewModel.dart';

main() {
  final MockClient client = MockClient();
  final TaskRepository svc = TaskRepository()..client = client;
  TasksListViewModel viewModel = TasksListViewModel(apiSvc: svc);

  test(
    'getDailyTasks test',
    () async {
      when(client.get('${NetworkConstants.BASE_URL}/${NetworkConstants.API_KEY}'))
          .thenAnswer(
        (_) async => http.Response('''

[
  {
    "id":"11126",
    "type":0,
    "title":"Aspirin 300",
    "description":"Take it with food",
    "dose":"1/2",
    "dueDate":"2020-06-22T19:30:00.000Z",
    "patientID":"215w4adas23asd1as3d21asd",
    "completedAt":""
  },
  {
    "id":"11127",
    "type":3,
    "title":"Measure your blood pressure",
    "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque eu congue est, id faucibus eros. Vivamus erat nunc, feugiat ut tortor ut, vulputate pulvinar sapien. Proin suscipit elit justo, ut sollicitudin libero pellentesque consectetur.",
    "dose":"",
    "dueDate":"2020-06-22T20:00:00.000Z",
    "patientID":"215w4adas23asd1as3d21asd",
    "completedAt":""
  }]

''', 200),
      );

      await viewModel.getDailyTasks();
      expect(await viewModel.tasks, isInstanceOf<List<Task>>());
    },
  );
}
