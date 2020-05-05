import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class CountryHistoryStatistics extends StatefulWidget {
  final CovidCountyHistoryModel covidCountyHistoryModel;
  const CountryHistoryStatistics(
      {@required this.covidCountyHistoryModel, Key key})
      : super(key: key);

  @override
  _CountryHistoryStatisticsState createState() =>
      _CountryHistoryStatisticsState();
}

class _CountryHistoryStatisticsState extends State<CountryHistoryStatistics> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<charts.Series<LinearPeople, DateTime>> _createRandomData() {
      final data = widget.covidCountyHistoryModel;
      List<LinearPeople> casesData = [];
      List<LinearPeople> recoveredData = [];
      List<LinearPeople> deathData = [];

      DateFormat format = DateFormat("MM/dd/yyyy");
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

    return Container(
      child: charts.TimeSeriesChart(
        _createRandomData(),
        behaviors: [
          new charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
         
            horizontalFirst: false,
          
           
            cellPadding: const EdgeInsets.only(right: 4.0, bottom: 4.0),
          
            showMeasures: true,
            
          measureFormatter: (num value) {
              return value == null ? '-' : ' :  $value';
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
          includePoints: true,

          // includeLine: false,
          radiusPx: 3.0,
          roundEndCaps: true,
        ),
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

class LinearPeople {
  final DateTime date;
  final int people;

  LinearPeople(this.date, this.people);
}
