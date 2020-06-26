import 'dart:async';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task/network/TaskRepository.dart';
import 'package:task/view_models/TasksListViewModel.dart';

import 'package:task/views/widgets/TasksPanel.dart';

class HomePage extends StatefulWidget {
  final TasksListViewModel HomePageVM;

  HomePage({Key key, this.HomePageVM}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(HomePageVM);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TasksListViewModel HomePageViewModel;

  _HomePageState(TasksListViewModel HomePageVM) {
    if (HomePageVM == null) {
      this.HomePageViewModel = TasksListViewModel(apiSvc: TaskRepository());
    } else {
      this.HomePageViewModel = HomePageVM;
    }
  }

  Future loadData() async {
    await this.HomePageViewModel.getDailyTasks();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
        ),
      ),
      body: ScopedModel<TasksListViewModel>(
        model: this.HomePageViewModel,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: TasksPanel(),
        ),
      ),
    );
  }
}
