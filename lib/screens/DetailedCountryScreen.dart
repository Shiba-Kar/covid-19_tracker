import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryHistoryStatistics.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class DetailedCountryScreen extends StatelessWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  const DetailedCountryScreen({@required this.covidDataCountriesModel, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiCall _apiCall = ApiCall();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        title: Text(covidDataCountriesModel.country),
        backgroundColor: mC,
      ),
      body: Container(
        child: FutureBuilder(
          future: _apiCall.getHistoricalData(covidDataCountriesModel.country),
          builder: (BuildContext context,
              AsyncSnapshot<CovidCountyHistoryModel> snapshot) {
            Widget active() {
              return Container(
                child: Text("Active State"),
              );
            }

            Widget done(CovidCountyHistoryModel data) {
              return Container(
                height: height/2,
                width: width,
                child: CountryHistoryStatistics(
                  covidCountyHistoryModel: data,
                ),
              );
            }

            Widget none() {
              return Container(
                child: Text("None State"),
              );
            }

            Widget waiting() {
              return LoadingIndicator();
            }

            Widget error() {
              return Container(
                child: Text("Error State"),
              );
            }

            if (!snapshot.hasData) {
              return waiting();
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return active();
                  break;
                case ConnectionState.waiting:
                  return waiting();
                case ConnectionState.none:
                  return none();
                case ConnectionState.done:
                  return done(snapshot.data);
                default:
                  return Container();
              }
            }
          },
        ),
      ),
    );
  }
}
