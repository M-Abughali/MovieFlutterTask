import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task/models/Task.dart';
import 'package:task/network/ITaskApi.dart';
import 'package:task/network/NetworkConstants.dart';

class TaskRepository implements ITaskAPi {
  http.Client _client = http.Client();

  set client(http.Client value) => _client = value;

  static final TaskRepository _instance = TaskRepository.internal();

  factory TaskRepository() {
    return _instance;
  }

  TaskRepository.internal();

  Future<List<Task>> getDailyTasks() async {
    var response = await _client
        .get('${NetworkConstants.BASE_URL}/${NetworkConstants.API_KEY}');
    print(response.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Task> tasks = List<Task>.from(data.map((x) => Task.fromJson(x)));
      DateTime today = new DateTime.now();
      List<Task> filteredTasks = filterTasksAccordingDateAndCompleted(tasks, today);
      return filteredTasks;
    } else {
      throw Exception('Failed to get data');
    }
  }

  List<Task> filterTasksAccordingDateAndCompleted(List<Task> tasks, DateTime dateTime) {
    List<Task> filteredTasks = List<Task>();

    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].isTaskForDateAndNotDone(dateTime)) {
        filteredTasks.add(tasks[i]);
      }
    }

    return filteredTasks;
  }
}
