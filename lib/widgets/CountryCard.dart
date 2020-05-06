import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryCard extends StatefulWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  const CountryCard({@required this.covidDataCountriesModel, Key key})
      : super(key: key);

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> with SingleTickerProviderStateMixin{
 AnimationController controller;
  Animation<Offset> scaleAnimation;
  @override
  void initState() {
      controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
     scaleAnimation  = Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
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
    Widget text(String text, Color color) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0),
      );
    }
 Widget updatedTime() {
          
          var x=DateTime.fromMicrosecondsSinceEpoch(widget.covidDataCountriesModel.updated * 1000);
          var formattedDate = DateFormat.yMMMd().format(x); 
                
          return Text("Updated on "+formattedDate,style: TextStyle(color: mCL),);
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
                      builder: (context) => DetailedCountryScreen(
                        covidDataCountriesModel: widget.covidDataCountriesModel,
                      ),
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
                          text(
                              "CASES : " +
                                  widget.covidDataCountriesModel.cases.toString(),
                              Colors.yellow),
                          text(
                              "ACTIVE : " +
                                  widget.covidDataCountriesModel.active
                                      .toString(),
                              Colors.blue),
                        ],
                      ),
                     Divider(
                       indent: 50.0,
                       color: Colors.white,
                       endIndent: 50.0,
                     ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          text(
                              "RECOVERED : " +
                                  widget.covidDataCountriesModel.recovered
                                      .toString(),
                              Colors.green),
                          text(
                              "DEATH : " +
                                  widget.covidDataCountriesModel.deaths
                                      .toString(),
                              Colors.red),
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
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                  flagUrl: widget.covidDataCountriesModel.countryInfo.flag,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
