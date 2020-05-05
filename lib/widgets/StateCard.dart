import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/StateDistrictCovidDataModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/screens/DetailedStateScreen.dart';
import 'package:covid_19/screens/IndianStatesCovidPage.dart';
import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class StateCard extends StatefulWidget {
  final StateDistrictCovidDataModel stateDistrictCovidDataModel;
  final int index;
  const StateCard(
      {@required this.stateDistrictCovidDataModel,
      @required this.index,
      Key key})
      : super(key: key);

  @override
  _StateCardState createState() => _StateCardState();
}

class _StateCardState extends State<StateCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

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

    return ScaleTransition(
      scale: scaleAnimation,
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
                        builder: (context) => DetailedStateScreen(
                              stateDistrictCovidDataModel: widget.stateDistrictCovidDataModel,
                            )),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    widget.stateDistrictCovidDataModel.state,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
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
