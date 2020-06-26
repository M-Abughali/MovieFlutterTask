import 'dart:async';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:task/models/Task.dart';
import 'package:task/network/ITaskApi.dart';

class TasksListViewModel extends Model {
  Future<List<Task>> _tasks;
  Future<List<Task>> get tasks => _tasks;
  set tasks(Future<List<Task>> value) {
    _tasks = value;
    notifyListeners();
  }

  final ITaskAPi apiSvc;

  TasksListViewModel({@required this.apiSvc});

  Future<bool> getDailyTasks() async {
    tasks = apiSvc?.getDailyTasks();
    return tasks != null;
  }


}