import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
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
    final ApiCall _apiCall = ApiCall();

    Widget body() {
      Widget active() {
        return Container(
          child: Text("In Active state"),
        );
      }

      Widget done(CovidDataAllModel data) {
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
                      end: data.cases.toDouble(),
                      color: Colors.yellow,
                    ),
                    CustomCard(
                      title: "ACTIVE",
                      end: data.active.toDouble(),
                      color: Colors.blue,
                    ),
                    CustomCard(
                        title: "RECOVERED",
                        end: data.recovered.toDouble(),
                        color: Colors.green),
                    CustomCard(
                        title: "DEATHS",
                        end: data.deaths.toDouble(),
                        color: Colors.red)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Worst Affected Countries",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
              FutureBuilder(
                  future: _apiCall.getFilteredCountries(filter: null),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CovidDataCountriesModel>> snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Center(child: Text(snapshot.error)),
                      );
                    } else {
                      Widget done(List<CovidDataCountriesModel> data) {
                        return Container(
                          height: height / 2.6,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return CountryCard(
                                  covidDataCountriesModel: data[index]);
                            },
                          ),
                        );
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                          return active();
                          break;
                        case ConnectionState.done:
                          return done(snapshot.data);
                          break;
                        case ConnectionState.waiting:
                          return LoadingIndicator();
                          break;
                        case ConnectionState.none:
                          return LoadingIndicator();
                          break;
                        default:
                          return Container(
                            child: Text("In defult"),
                          );
                      }
                    }

                    /*  Container(
              height: height / 2.6,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CountryCard(
                      covidDataCountriesModel: data[index]);
                },
              ),
            ) */
                  })
            ],
          ),
        );

        //////////////////////////
        /*  return Container(
          child: Scrollbar(
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return CountryCard(
                  covidDataCountriesModel: data[index],
                );
              },
            ),
          ),
        ); */
      }

      Widget error(Object error) {
        return Container(child: Center(child: Text(error.toString())));
      }

      return FutureBuilder(
        future: _apiCall.getCovidDataGolobal(),
        builder:
            (BuildContext context, AsyncSnapshot<CovidDataAllModel> snapshot) {
          if (snapshot.hasError) {
            return error(snapshot.error);
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return active();
                break;
              case ConnectionState.done:
                return done(snapshot.data);
                break;
              case ConnectionState.waiting:
                return LoadingIndicator();
                break;
              case ConnectionState.none:
                return LoadingIndicator();
                break;
              default:
                return Container(
                  child: Text("In defult"),
                );
            }
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        backgroundColor: mC,
        elevation: 0.0,
        title: Text("Covid-19"),
      ),
      body: body(),
    );
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
            duration: Duration(seconds: 2),
            curve: Curves.easeInSine,
          )
        ],
      ),
    );
  }
}
