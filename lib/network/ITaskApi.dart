import 'dart:async';

import 'package:task/models/Task.dart';

abstract class ITaskAPi {
  Future<List<Task>> getDailyTasks();
}