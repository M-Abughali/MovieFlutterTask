import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/utils/GeneralStyles.dart';
import 'file:///H:/GermanyTest/Kotlin/task/lib/views/pages/SoonPage.dart';

import 'HomePage.dart';


class MainPageView extends StatefulWidget {

  MainPageView();

  @override
  State<StatefulWidget> createState() {
    return new MainPageViewState();
  }
}

class MainPageViewState extends State<MainPageView>
    with SingleTickerProviderStateMixin {

  MainPageViewState();
  TabController controller;
  int myIndex = 0;
  int currentTab;
  HomePage homeView = HomePage();
  SoonPage soonPage = SoonPage();

  List<Widget> pages;
  Widget currentPage;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 5, vsync: this);
    controller.addListener(_handleTabSelection);
    pages = [homeView, soonPage, soonPage, soonPage,soonPage];
    currentTab = myIndex;
    currentPage = pages[myIndex];
  }

  //Where the page is created

  _exitApp(BuildContext context) {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: currentPage,
      bottomNavigationBar: SizedBox(

          child: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.white,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: new TextStyle(
                        color: Colors.grey, fontSize: 8.0))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentTab,
              onTap: (int index) {
                setState(() {
                  currentTab = index;
                  currentPage = pages[index];
                });
              },
              //fixedColor: Colors.white,
              // this will be set when a new tab is tapped
              items: [
                _createBottomNavigationItem(
                    "assets/images/home_icon.svg",
                    "Home",
                    0),
                _createBottomNavigationItem(
                    "assets/images/my_tasks_icon.svg",
                    "My Tasks",
                    1),
                _createBottomNavigationItem(
                    "assets/images/my_health_icon.svg",
                    "My Health",
                    2),

                _createBottomNavigationItem(
                    "assets/images/services_icon.svg",
                    "Services",
                    3),

                _createBottomNavigationItem(
                    "assets/images/settings_icon.svg",
                    "Settings",
                    4),

              ],
            ),
          )),
    );
  }

  BottomNavigationBarItem _createBottomNavigationItem(
      String iconAsset, String title, int index) {
    return BottomNavigationBarItem(
        icon:
        SvgPicture.asset(
            iconAsset,
            color: currentTab == index ? GeneralStyles.primaryColor : GeneralStyles.inActiveColor
        ),
        title: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(title,
                style: TextStyle(
                    color:
                    currentTab == index ? GeneralStyles.primaryColor : GeneralStyles.inActiveColor,
                    fontSize: 11.0))));
  }

}
