import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataIndianModel.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class IndianStatisticsLineChartDaily extends StatefulWidget {
  final CovidDataIndianModel indianCovidDataModel;
  const IndianStatisticsLineChartDaily(
      {@required this.indianCovidDataModel, Key key})
      : super(key: key);

  @override
  _IndianStatisticsLineChartDailyState createState() =>
      _IndianStatisticsLineChartDailyState();
}

class _IndianStatisticsLineChartDailyState extends State<IndianStatisticsLineChartDaily> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<CasesTimeSery> data =
        widget.indianCovidDataModel.casesTimeSeries;

    List<charts.Series<LinearPeople, DateTime>> _createRandomData() {
      DateFormat format = DateFormat('dd MMMM');
      List<LinearPeople> dailyconfirmed = [];
      List<LinearPeople> dailydeceased = [];
      List<LinearPeople> dailyrecovered = [];
    
     

      for (var i = 0; i < data.length; i++) {
        dailyconfirmed.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].dailyconfirmed)));
        dailydeceased.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].dailydeceased)));
        dailyrecovered.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].dailyrecovered)));
      }
    for (var i = 0; i < dailyconfirmed.length; i++) {
      print(dailyconfirmed[i].date);
    }
     

      return [
     
         charts.Series<LinearPeople, DateTime>(
          id: "dailyconfirmed",
         // strokeWidthPxFn: (datum, index) => 5.0,
          displayName: "Daily Confirmed",
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: dailyconfirmed,
        ),


         charts.Series<LinearPeople, DateTime>(
          id: "dailydeceased",
         // strokeWidthPxFn: (datum, index) => 5.0,
          displayName: "Daily Deceased",
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: dailyrecovered,
        ),


         charts.Series<LinearPeople, DateTime>(
          id: "dailyrecovered",
          strokeWidthPxFn: (datum, index) => 3.0,
          displayName: "Daily Recovered",
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: dailyrecovered,
        ),



        
      ];
    }

    return Container(
      child: charts.TimeSeriesChart(
        _createRandomData(),
        behaviors: [
          new charts.SeriesLegend(
            position: charts.BehaviorPosition.inside,
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
          new charts.SelectNearest(), new charts.DomainHighlighter()
        ],
        defaultRenderer:charts.LineRendererConfig(
          includeArea: true,
          stacked: false,
          

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
