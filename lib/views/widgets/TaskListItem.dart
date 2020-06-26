import 'package:flutter/material.dart';
import 'package:task/models/Task.dart';
import 'package:task/utils/TaskStyles.dart';
import 'package:task/views/pages/SoonPage.dart';

class TaskListItem extends StatelessWidget {

  final VoidCallback action;

  final Task task;

  TaskListItem({@required this.task,@required this.action});

  @override
  Widget build(BuildContext context) {
    var title = Text(
      task?.title,
      style: TextStyle(
        color: TaskStyles.titleColor,
        fontWeight: FontWeight.bold,
        fontSize: TaskStyles.titleFontSize,
        fontFamily: 'Montserrat-SemiBold',
      ),
    );

    var subTitle = Text(
      task?.dose.toString() + " " + task?.dueDate.toString(),
      style: TextStyle(
        color: TaskStyles.subTitleColor,
        fontFamily: 'Montserrat-SemiBold',
      ),
    );

    return GestureDetector(
      onTap: action,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              title: title,
              subtitle: subTitle,
            )
          ],
        ),
      ),
    );
  }
}
