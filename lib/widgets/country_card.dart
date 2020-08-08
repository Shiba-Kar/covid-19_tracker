import 'package:covid_19/models/covid_data_countries_model.dart';
import 'package:covid_19/screens/detailed_country_screen.dart';

import 'package:covid_19/widgets/Nm_box.dart';
import 'package:covid_19/widgets/glow_flags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryCard extends StatefulWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  final bool tapable;
  const CountryCard(
      {@required this.covidDataCountriesModel, @required this.tapable, Key key})
      : super(key: key);

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard>
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
      var x = DateTime.fromMicrosecondsSinceEpoch(
          widget.covidDataCountriesModel.updated * 1000);
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
                  onTap: () => widget.tapable
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailedCountryScreen(
                                covidDataCountriesModel:
                                    widget.covidDataCountriesModel),
                          ),
                        )
                      : null,
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
                                    widget.covidDataCountriesModel.cases
                                        .toString(),
                                    Colors.yellow,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.covidDataCountriesModel.todayCases
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
                                widget.covidDataCountriesModel.active
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
                          Row(
                            children: <Widget>[
                              text(
                                "RECOVERED : ",
                                Colors.green,
                                FontWeight.bold,
                              ),
                              text(
                                widget.covidDataCountriesModel.recovered
                                    .toString(),
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
                                    widget.covidDataCountriesModel.deaths
                                        .toString(),
                                    Colors.red,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                              text(
                                "+" +
                                    widget.covidDataCountriesModel.todayDeaths
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.covidDataCountriesModel.country,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      updatedTime()
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
                child: GlowFlags(
                    flagUrl: widget.covidDataCountriesModel.countryInfo.flag),
              ),
            )
          ],
        ),
      ),
    );
  }
}
