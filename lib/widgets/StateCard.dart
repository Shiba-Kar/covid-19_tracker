import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/CovidDataIndianModel.dart';
import 'package:covid_19/screens/DistrictsScreen.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StateCard extends StatefulWidget {
  final Statewise stateWise;
  final int index;
  final bool tapable;
  const StateCard(
      {@required this.stateWise,
      @required this.index,
      @required this.tapable,
      Key key})
      : super(key: key);

  @override
  _StateCardState createState() => _StateCardState();
}

class _StateCardState extends State<StateCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> scaleAnimation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation = Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Widget text(String text, Color color, FontWeight fontWeight) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0, fontWeight: fontWeight),
      );
    }

    Widget updatedTime() {
      var x = DateTime.parse(widget.stateWise.lastupdatedtime);
      var formattedDate = DateFormat.yMMMd().format(x);

      return Text(
        "Updated on " + formattedDate,
        style: TextStyle(color: mCL),
      );
    }

    return SlideTransition(
      position: scaleAnimation,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width / 1.23,
                decoration: nMboxInvert,
                child: ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DistrictsScreen(
                        stateCode: widget.stateWise.statecode,
                        state: widget.stateWise.state,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    widget.stateWise.state,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
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
                                    widget.stateWise.confirmed.toString(),
                                    Colors.yellow,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.stateWise.deltaconfirmed.toString(),
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
                                widget.stateWise.active.toString(),
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
                          Row(
                            children: <Widget>[
                              text(
                                "RECOVERED : ",
                                Colors.green,
                                FontWeight.bold,
                              ),
                              text(
                                widget.stateWise.confirmed.toString(),
                                Colors.green,
                                FontWeight.normal,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: <Widget>[
                                  text(
                                    "DEATH : ",
                                    Colors.red,
                                    FontWeight.bold,
                                  ),
                                  text(
                                    widget.stateWise.deaths.toString(),
                                    Colors.red,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" + widget.stateWise.deltadeaths.toString(),
                                Colors.red,
                                FontWeight.bold,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
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
      ),
    );
  }
}
