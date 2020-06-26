import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:task/models/Task.dart';
import 'package:task/utils/TaskStyles.dart';
import 'package:task/view_models/TasksListViewModel.dart';
import 'package:task/views/pages/SoonPage.dart';
import 'package:task/views/pages/TaskDetailsPage.dart';
import 'package:task/views/widgets/TaskListItem.dart';
import 'package:task/views/widgets/NoInternetConnection.dart';

class TasksPanel extends StatefulWidget {
  @override
  _TasksPanelState createState() => _TasksPanelState();
}

class _TasksPanelState extends State<TasksPanel> {
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScopedModelDescendant<TasksListViewModel>(
        builder: (context, child, model) {
          return FutureBuilder<List<Task>>(
            future: model.tasks,
            builder: (_, AsyncSnapshot<List<Task>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(child: const CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    print("snapshot.hasData" + snapshot.hasData.toString());
                    tasks = snapshot.data;

                    if (tasks.length == 0) {
                      return Center(
                          child: Text(
                        "Great Job Every thing done for the day ",
                        style: TextStyle(
                          color: TaskStyles.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: TaskStyles.titleFontSize,
                          fontFamily: 'Montserrat-SemiBold',
                        ),
                      ));
                    } else {
                      return ListView.builder(
                        itemCount: tasks == null ? 0 : tasks.length,
                        itemBuilder: (_, int index) {
                          var task = tasks[index];
                          return TaskListItem(
                            task: task,
                            action: () {
                              onTaskClickListener(index);
                            },
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return NoInternetConnection(
                      action: () async {
                        await model.getDailyTasks();
                      },
                    );
                  }
              }
            },
          );
        },
      ),
    );
  }

  void onTaskClickListener(int index) {
    Navigator.push<bool>(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetailsPage(task: tasks[index])))
        .then((value) {
      if (value == true) {
        setState(() {
          tasks.removeAt(index);
        });
      }
    });
  }
}
