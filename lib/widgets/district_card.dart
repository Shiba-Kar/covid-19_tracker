import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/state_district_covid_data_model.dart';

import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class DistrictCard extends StatefulWidget {
  final DistrictDatum district;
  final int index;
  const DistrictCard({@required this.district,@required this.index, Key key}) : super(key: key);

  @override
  _DistrictCardState createState() => _DistrictCardState();
}

class _DistrictCardState extends State<DistrictCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget text(String text, Color color, FontWeight fontWeight) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: width/30, fontWeight: fontWeight),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10.0),
  
      child:  Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width / 1.23,
                decoration: nMboxInvert,
                child: ListTile(
                  
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  text(
                                    "CASES : ",
                                    Colors.yellow,
                                    FontWeight.bold,
                                  
                                  ),
                                  text(
                                    widget.district.confirmed
                                        .toString(),
                                    Colors.yellow,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.district.delta.confirmed
                                        .toString(),
                                Colors.yellow,
                                FontWeight.bold,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              text(
                                "ACTIVE : ",
                                Colors.blue,
                                FontWeight.bold,
                              ),
                              text(
                                widget.district.active
                                    .toString(),
                                Colors.blue,
                                FontWeight.normal,
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        // indent: 50.0,
                        color: Colors.white,
                        // endIndent: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  text(
                                    "RECOVERED : ",
                                    Colors.green,
                                    FontWeight.bold,
                                  ),
                                  text(
                                    widget.district.recovered
                                        .toString(),
                                    Colors.green,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.district.delta.recovered
                                        .toString(),
                                Colors.green,
                                FontWeight.bold,
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: <Widget>[
                                  text(
                                    "Deseased : ",
                                    Colors.red,
                                    FontWeight.bold,
                                  ),
                                  text(
                                    widget.district.deceased
                                        .toString(),
                                    Colors.red,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.district.delta.deceased
                                        .toString(),
                                Colors.red,
                                FontWeight.bold,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    widget.district.district,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
           Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  //color: Colors.red,
                  height: height / 10,
                  width: height / 10,
                  child: AvatarGlow(
                    startDelay: Duration(milliseconds: 1000),
                    glowColor: Colors.white,
                    endRadius: 50.0,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    showTwoGlows: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: mC,
                        child: Text((widget.index + 1).toString()),
                        radius: 25.0,
                      ),
                    ),
                    shape: BoxShape.circle,
                    animate: true,
                    curve: Curves.fastOutSlowIn,
                  )),
            )
          ],
        ),
    );
  }
}
