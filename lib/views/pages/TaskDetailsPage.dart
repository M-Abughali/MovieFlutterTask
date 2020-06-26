import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:sprintf/sprintf.dart';
import 'package:task/models/Task.dart';
import 'package:task/utils/GeneralStyles.dart';
import 'package:task/utils/TaskStyles.dart';

class TaskDetailsPage extends StatefulWidget {
  Task task;

  TaskDetailsPage({@required this.task});

  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState(task);
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  Task task;
  bool isCompleted = false;
  DateTime _dateTime;

  _TaskDetailsPageState(this.task);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Task overview"),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
          shape: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.05)),
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Created by doctor",
                        style: TextStyle(
                          color: GeneralStyles.gray200,
                          fontWeight: FontWeight.bold,
                          fontSize: GeneralStyles.fontSize15,
                          fontFamily: GeneralStyles.fontFamilySemiBold,
                        ),
                      ),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          taskInfo("Medicine name", task.title, "medication_name_icon.svg"),
                          Divider(),
                          taskInfo(
                              "Time & Quantity",
                              "${task.dueDate.hour} : ${task.dueDate.minute}",
                              "time_quantity_icon.svg"),
                          Divider(),
                          taskInfo("Description", task.description, "descripton_icon.svg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _selectDateButton(),
              )
            ],
          ),
        ));
  }

  Widget taskInfo(String headertxt, String titleTxt, String icon) {
    var header = Text(
      headertxt,
      style: TextStyle(
        color: TaskStyles.titleColor,
        fontWeight: FontWeight.bold,
        fontSize: TaskStyles.titleFontSize,
        fontFamily: GeneralStyles.fontFamilySemiBold,
      ),
    );

    var content = Text(
      titleTxt,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: TaskStyles.subTitleColor,
        fontFamily: GeneralStyles.fontFamilySemiBold,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              "assets/images/"+icon,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[header, content],
          )
        ],
      ),
    );
  }

  void _submitSelectedDate() {
    Navigator.of(context).pop();
    Navigator.of(context).pop(isCompleted);
  }

  Widget _selectDateButton() {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, right: 0, left: 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              color: GeneralStyles.primaryColor,
              borderRadius: new BorderRadius.circular(2.0)),
          child: FlatButton(
            onPressed: () {
              _showTimePickerDialog();
            },
            textColor: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Mark it as done",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _showTimePickerDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            "assets/images/close_btn.svg",
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        sprintf(
                            "What time did you take %s? ", ["${task.title}"]),
                        style: TextStyle(
                          color: TaskStyles.subTitleColor,
                          fontFamily: GeneralStyles.fontFamilySemiBold,
                        ),
                      ),
                      _timePickerSpinner(),
                      _dialogSubmitButton(),
                    ],
                  )
                ],
              ),
            ));

    /*
    return
     */
  }

  Widget _timePickerSpinner() {
    return new TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      highlightedTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      spacing: 30,
      itemHeight: 50,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget _dialogSubmitButton() {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 0, left: 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              color: GeneralStyles.primaryColor,
              borderRadius: new BorderRadius.circular(2.0)),
          child: FlatButton(
            onPressed: () {
              isCompleted = true;
              _submitSelectedDate();
            },
            textColor: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
