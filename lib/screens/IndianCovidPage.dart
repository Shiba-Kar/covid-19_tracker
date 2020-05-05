import 'package:covid_19/models/CovidDataIndianModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/IndianCard.dart';

import 'package:covid_19/widgets/IndianStatisticsLineChartDaily.dart';
import 'package:covid_19/widgets/IndianStatisticsLineChartTotal.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndianCovidPage extends StatefulWidget {
  IndianCovidPage({Key key}) : super(key: key);

  @override
  _IndianCovidPageState createState() => _IndianCovidPageState();
}

class _IndianCovidPageState extends State<IndianCovidPage> {
  final ApiCall _apiCall = ApiCall();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    Widget done(CovidDataIndianModel data) {
      return ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Live Indian Statistics",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          Container(
            height: height / 2,
            child: ListView(
              physics: ScrollPhysics(parent: ScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  height: height / 2,
                  width: width / 2,
                  child: IndianStatisticsLineChartDaily(
                    indianCovidDataModel: data,
                  ),
                ),
                Container(
                  height: height / 2,
                  width: width / 2,
                  child: IndianStatisticsLineChartTotal(
                    indianCovidDataModel: data,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Worst Affected States",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          Container(
            width: width,
            height: height / 2.6,
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return IndianCard(sateWise: data.statewise[index]);
              },
              // scrollDirection: Axis.horizontal,
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Indian Statistics"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _apiCall.getIndianData(),
          builder: (BuildContext context,
              AsyncSnapshot<CovidDataIndianModel> snapshot) {
            if (snapshot.hasError) {
              return Container(
                  child: Center(
                child: Text("Error" + '${snapshot.error}'),
              ));
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return done(snapshot.data);
                  break;
                case ConnectionState.active:
                  return Container();
                  break;
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                  return LoadingIndicator();
                  break;

                default:
                  return Container();
              }
            }
          }),
    );
  }
}
