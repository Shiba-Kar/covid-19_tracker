import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
import 'package:covid_19/widgets/CustomGridCard.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        Widget updatedTime() {
          var x = DateTime.fromMicrosecondsSinceEpoch(data.updated * 1000);
          var formattedDate = DateFormat.yMMMd().format(x);

          return Text("Updated on " + formattedDate);
        }

        return Container(
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Live Global Statistics",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    updatedTime()
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                height: height / 2,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  children: <Widget>[
                    CustomGridCard(
                      title: "CASES",
                      end: data.cases.toDouble(),
                      color: Colors.yellow,
                      showChange: true,
                      changeValue: data.todayCases.toString(),
                    ),
                    CustomGridCard(
                      title: "ACTIVE",
                      end: data.active.toDouble(),
                      color: Colors.blue,
                      showChange: false,
                    ),
                    CustomGridCard(
                      title: "RECOVERED",
                      end: data.recovered.toDouble(),
                      color: Colors.green,
                      showChange: false,
                    ),
                    CustomGridCard(
                      title: "DEATHS",
                      end: data.deaths.toDouble(),
                      color: Colors.red,
                      showChange: true,
                      changeValue: data.todayDeaths.toString(),
                    ),
                    CustomGridCard(
                      title: "CRITICAL",
                      end: data.critical.toDouble(),
                      color: Colors.orange,
                      showChange: false,
                    ),
                    CustomGridCard(
                      title: "TESTS",
                      end: data.tests.toDouble(),
                      color: Colors.brown,
                      showChange: false,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Worst Affected Countries",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
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
                              tapable: true,
                              covidDataCountriesModel: data[index],
                            );
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
                },
              )
            ],
          ),
        );
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
       /*  actions: <Widget>[
          Container(
            decoration: nMbox,
            margin: const EdgeInsets.all(7.0),
            child: IconButton(
              icon: Icon(Icons.info),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,

                builder: (BuildContext context) => AboutMeDialog(),
              ),
            ),
          )
        ], */
        backgroundColor: mC,
        elevation: 0.0,
        centerTitle: true,
        title: Text("COVID-19 Tracker"),
      ),
      body: body(),
    );
  }
}
