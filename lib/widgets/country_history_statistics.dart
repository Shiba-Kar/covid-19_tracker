import 'package:covid_19/models/covid_county_history_model.dart';
import 'package:covid_19/services/api_call.dart';
import 'package:covid_19/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class CountryHistoryStatistics extends StatefulWidget {
  final String country;
  const CountryHistoryStatistics({@required this.country, Key key})
      : super(key: key);

  @override
  _CountryHistoryStatisticsState createState() =>
      _CountryHistoryStatisticsState();
}

class _CountryHistoryStatisticsState extends State<CountryHistoryStatistics> {
  int _pastRecords = 10;
  final ApiCall _apiCall = ApiCall();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final simpleNumberFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
      new NumberFormat.compact(),
    );

    Widget done(CovidCountyHistoryModel data) {
      List<charts.Series<LinearPeople, DateTime>> _createRandomData() {
        List<LinearPeople> casesData = [];
        List<LinearPeople> recoveredData = [];
        List<LinearPeople> deathData = [];

        DateFormat format = DateFormat("MM/dd/yy");
        data.timeline.cases.forEach((key, value) {
          casesData.add(
            LinearPeople(format.parse(key), value),
          );
        });
        data.timeline.recovered.forEach((key, value) {
          recoveredData.add(
            LinearPeople(format.parse(key), value),
          );
        });
        data.timeline.deaths.forEach((key, value) {
          deathData.add(
            LinearPeople(format.parse(key), value),
          );
        });
        print(casesData[0].date);
        return [
          charts.Series<LinearPeople, DateTime>(
            id: 'Cases',
            strokeWidthPxFn: (datum, index) => 5.0,
            displayName: "Cases",
            colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
            domainFn: (LinearPeople sales, _) => sales.date,
            measureFn: (LinearPeople sales, _) => sales.people,
            data: casesData,
          ),
          charts.Series<LinearPeople, DateTime>(
            id: 'Recovered',
            displayName: "Recovered",
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (LinearPeople sales, _) => sales.date,
            measureFn: (LinearPeople sales, _) => sales.people,
            data: recoveredData,
          ),
          charts.Series<LinearPeople, DateTime>(
            id: 'Death',
            labelAccessorFn: (datum, index) => datum.date.toString(),
            displayName: "Death",
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (LinearPeople sales, _) => sales.date,
            measureFn: (LinearPeople sales, _) => sales.people,
            data: deathData,
          )
        ];
      }

      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("Statistics for "),
              DropdownButton(
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    _pastRecords = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text("10"),
                    value: 10,
                  ),
                  DropdownMenuItem(
                    child: Text("30"),
                    value: 30,
                  ),
                  DropdownMenuItem(
                    child: Text("60"),
                    value: 60,
                  ),
                  DropdownMenuItem(
                    child: Text("90"),
                    value: 90,
                  ),
                  DropdownMenuItem(
                    child: Text("120"),
                    value: 120,
                  ),
                  DropdownMenuItem(
                    child: Text("150"),
                    value: 150,
                  ),
                  DropdownMenuItem(
                    child: Text("180"),
                    value: 180,
                  ),
                ],
                value: _pastRecords,
              ),
              Text("days "),
            ],
          ),
          Container(
            height: height / 2,
            child: charts.TimeSeriesChart(
              _createRandomData(),
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickFormatterSpec: simpleNumberFormatter,
                renderSpec: new charts.GridlineRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.gray.shadeDefault,
                    thickness: 0,
                    dashPattern: [2, 2, 1, 1],
                  ),
                ),
              ),
              domainAxis: charts.DateTimeAxisSpec(
                renderSpec: new charts.GridlineRendererSpec(
                  labelAnchor: charts.TickLabelAnchor.inside,
                  lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.gray.shadeDefault,
                    thickness: 0,
                    dashPattern: [2, 2, 1, 1],
                  ),
                  labelStyle: new charts.TextStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                ),
              ),
              behaviors: [
                new charts.SeriesLegend(
                  position: charts.BehaviorPosition.bottom,
                  horizontalFirst: false,
                  cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
                  showMeasures: true,
                  measureFormatter: (num value) {
                    return value == null ? '-' : ' : $value';
                  },
                  /*  secondaryMeasureFormatter: (num value){
              return value==null?'-':'$value';
            } */
                ),
              ],
              defaultRenderer: charts.LineRendererConfig(
                includeArea: true,
                stacked: false,
                areaOpacity: 0.4,
                // includePoints: true,

                // includeLine: false,
                radiusPx: 3.0,
                roundEndCaps: true,
              ),
              animate: true,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            ),
          )
        ],
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

    Widget body() {
      return Container(
        child: FutureBuilder<CovidCountyHistoryModel>(
          future: _apiCall.getHistoricalData(
              country: widget.country, pastRecords: _pastRecords),
          builder: (BuildContext context,
              AsyncSnapshot<CovidCountyHistoryModel> snapshot) {
            Widget active() {
              return Container(
                child: Text("Active State"),
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
      );
    }

    return body();
  }
}

class LinearPeople {
  final DateTime date;
  final int people;

  LinearPeople(this.date, this.people);
}
