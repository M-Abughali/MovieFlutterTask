import 'package:flutter/material.dart';
import 'package:task/view_models/MainPageViewModel.dart';
import 'package:task/views/pages/mainPage.dart';

import 'network/MovieApiService.dart';


final MainPageViewModel mainPageVM = MainPageViewModel(apiSvc: MovieApiService());

void main() => runApp(MvvmApp(mainPageVM: mainPageVM));

class MvvmApp extends StatelessWidget {
  final MainPageViewModel mainPageVM;

  MvvmApp({@required this.mainPageVM});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: new ThemeData(
        primaryColor: Color(0xff070707),        
        primaryColorLight: Color(0xff0a0a0a),
        primaryColorDark: Color(0xff000000),
      ),
      home: MainPage(viewModel: mainPageVM),
      debugShowCheckedModeBanner: false,
    );
  }
}