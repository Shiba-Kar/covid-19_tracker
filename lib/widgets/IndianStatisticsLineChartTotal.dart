import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataIndianModel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class IndianStatisticsLineChartTotal extends StatefulWidget {
  final CovidDataIndianModel indianCovidDataModel;
  const IndianStatisticsLineChartTotal(
      {@required this.indianCovidDataModel, Key key})
      : super(key: key);

  @override
  _IndianStatisticsLineChartTotalState createState() =>
      _IndianStatisticsLineChartTotalState();
}

class _IndianStatisticsLineChartTotalState
    extends State<IndianStatisticsLineChartTotal> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<CasesTimeSery> data =
        widget.indianCovidDataModel.casesTimeSeries;

    List<charts.Series<LinearPeople, DateTime>> _createRandomData() {
      DateFormat format = DateFormat('dd MMMM');

      List<LinearPeople> totalconfirmed = [];
      List<LinearPeople> totaldeceased = [];
      List<LinearPeople> totalrecovered = [];

      for (var i = 0; i < data.length; i++) {
        totalconfirmed.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].totalconfirmed)));
        totaldeceased.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].totaldeceased)));
        totalrecovered.add(LinearPeople(
            format.parse(data[i].date), int.parse(data[i].totalrecovered)));
      }

      return [
        charts.Series<LinearPeople, DateTime>(
          id: "totalconfirmed",
         // strokeWidthPxFn: (datum, index) => 5.0,
          displayName: "Total Confirmed",
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: totalconfirmed,
        ),
        charts.Series<LinearPeople, DateTime>(
          id: "totaldeceased",
         // strokeWidthPxFn: (datum, index) => 5.0,
          displayName: "Total Deceased",
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: totaldeceased,
        ),
        charts.Series<LinearPeople, DateTime>(
          id: "totalrecovered",
          strokeWidthPxFn: (datum, index) => 3.0,
          displayName: "Total Recovered",
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearPeople sales, _) => sales.date,
          measureFn: (LinearPeople sales, _) => sales.people,
          data: totalrecovered,
        )
      ];
    }
final simpleNumberFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
      new NumberFormat.compact(),
    );

    return Container(
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
                dashPattern: [2, 2, 1, 1]),
          ),
        ),
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
          includeLine: true,
          

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
