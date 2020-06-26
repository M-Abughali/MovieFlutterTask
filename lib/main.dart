import 'package:flutter/material.dart';
import 'package:task/utils/GeneralStyles.dart';
import 'package:task/views/pages/HomePage.dart';
import 'package:task/views/pages/MainPageView.dart';



void main() => runApp(MvvmApp());

class MvvmApp extends StatelessWidget {

  MvvmApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: new ThemeData(
        primaryColor: GeneralStyles.primaryColor,
        primaryColorLight: GeneralStyles.primaryColorLight,
        primaryColorDark: GeneralStyles.primaryColorDark,
      ),
      home: MainPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}