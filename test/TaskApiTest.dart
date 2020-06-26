import 'package:flutter_test/flutter_test.dart';
import 'package:task/models/Task.dart';
import 'package:task/network/ITaskApi.dart';
import 'package:task/network/TaskRepository.dart';

void main() {
  final ITaskAPi svc = TaskRepository();

  test(
    'get getDailyTasks request test',
    () async {
      expect(await svc.getDailyTasks(), isInstanceOf<List<Task>>());
    },
  );


}