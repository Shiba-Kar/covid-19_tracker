import 'dart:ui';

import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:mccounting_text/mccounting_text.dart';

class CustomGridCard extends StatelessWidget {
  final String title;
  final double end;
  final Color color;

  final bool showChange;
  final String changeValue;
  const CustomGridCard({
    @required this.color,
    @required this.title,
    @required this.end,
    @required this.showChange,
    this.changeValue,
  
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconShow() {
      return Row(
        children: <Widget>[
          Text("   "+changeValue,style: TextStyle(color: color),),
          Icon(
            Icons.arrow_upward,
            color: color,
          ),
        ],
      );
    }

    return Container(
      decoration: nMbox,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 30.0, color: color)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              McCountingText(
                style: TextStyle(fontSize: 25.0, color: Colors.grey[400]),
                begin: 0,
                end: end,
                duration: Duration(seconds: 2),
                curve: Curves.easeInSine,
              ),
              showChange ? iconShow() : Container()
            ],
          ),
        ],
      ),
    );
  }
}
