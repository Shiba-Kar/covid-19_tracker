import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalCovidPage extends StatefulWidget {
  GlobalCovidPage({Key key}) : super(key: key);

  @override
  _GlobalCovidPageState createState() => _GlobalCovidPageState();
}

class _GlobalCovidPageState extends State<GlobalCovidPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final CovidDataAllModel _covidDataAllModel =
        Provider.of<CovidDataAllModel>(context);
    final List<CovidDataCountriesModel> _covidDataCountriesModel =
        Provider.of<List<CovidDataCountriesModel>>(context);
    Widget dataIsPresent() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Live Global Statistics",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0.0),
              height: height / 3,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  CustomCard(
                    title: "CASES",
                    end: _covidDataAllModel.cases.toDouble(),
                    color: Colors.yellow,
                  ),
                  CustomCard(
                    title: "ACTIVE",
                    end: _covidDataAllModel.active.toDouble(),
                    color: Colors.blue,
                  ),
                  CustomCard(
                      title: "RECOVERED",
                      end: _covidDataAllModel.recovered.toDouble(),
                      color: Colors.green),
                  CustomCard(
                      title: "DEATHS",
                      end: _covidDataAllModel.deaths.toDouble(),
                      color: Colors.red)
                ],
              ),
            ),
            Text(
              "Worst affected Countries",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            Container(
              height: height / 2.6,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CountryCard(
                      covidDataCountriesModel: _covidDataCountriesModel[index]);
                },
              ),
            )
          ],
        ),
      );
    }

    return _covidDataAllModel != null && _covidDataCountriesModel != null
        ? dataIsPresent()
        : LoadingIndicator();
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final double end;
  final Color color;
  const CustomCard(
      {@required this.color, @required this.title, @required this.end, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: nMbox,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 30.0, color: color)),
          McCountingText(
            style: TextStyle(fontSize: 25.0, color: Colors.grey[400]),
            begin: 0,
            end: end,
            duration: Duration(seconds: 9),
            curve: Curves.easeInSine,
          )
        ],
      ),
    );
  }
}

class CountryCard extends StatefulWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  const CountryCard({@required this.covidDataCountriesModel, Key key})
      : super(key: key);

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
final height =MediaQuery.of(context).size.height;
    Widget text(String text, Color color) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0),
      );
    }

    return Container(
     
     margin: const EdgeInsets.all(10.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
             width: width/1.23,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(
                        "CASES : " +
                            widget.covidDataCountriesModel.cases.toString(),
                        Colors.yellow),
                    text(
                        "ACTIVE : " +
                            widget.covidDataCountriesModel.active.toString(),
                        Colors.blue),
                    text(
                        "RECOVERED : " +
                            widget.covidDataCountriesModel.recovered.toString(),
                        Colors.green),
                    text(
                        "DEATH : " +
                            widget.covidDataCountriesModel.deaths.toString(),
                        Colors.red),
                  ],
                ),
                contentPadding: const EdgeInsets.all(10.0),
                title: Text(
                  widget.covidDataCountriesModel.country,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              //color: Colors.red,
              height: height/10,
              width: height/10,
              child: GlowFlags(
                flagUrl: widget.covidDataCountriesModel.countryInfo.flag,
              ),
            ),
          )
        ],
      ),
    );
  }
}
