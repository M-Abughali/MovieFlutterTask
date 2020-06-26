import 'package:flutter/material.dart';

class SoonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SoonPageState();
  }
}

class _SoonPageState extends State<SoonPage> {

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Soon",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: null,
            body: Stack(
              children: <Widget>[
                body(),
              ],
            )));
  }

}
