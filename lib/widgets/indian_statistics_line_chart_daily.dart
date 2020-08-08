
import 'package:covid_19/models/covid_data_indian_model.dart';

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

class _IndianStatisticsLineChartDailyState
    extends State<IndianStatisticsLineChartDaily> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List<CasesTimeSery> data =widget.indianCovidDataModel.casesTimeSeries;

    List<charts.Series<LinearPeople, DateTime>> _createRandomData() {
      DateFormat format = DateFormat.yMMMd();
      List<LinearPeople> dailyconfirmed = [];
      List<LinearPeople> dailydeceased = [];
      List<LinearPeople> dailyrecovered = [];
      
      
      DateTime addYearAndFormat(String date) {
        var dateTime3 = DateFormat('dd MMMM').parse(date);
        var y =
            DateFormat.yMMMd().format(dateTime3).replaceAll(', 1970', ', 2020');
        return format.parse(y);
      }

      for (var i = 0; i < data.length; i++) {
        dailyconfirmed.add(LinearPeople(
            addYearAndFormat(data[i].date), int.parse(data[i].dailyconfirmed)));
        dailydeceased.add(LinearPeople(
            addYearAndFormat(data[i].date), int.parse(data[i].dailydeceased)));
        dailyrecovered.add(LinearPeople(
            addYearAndFormat(data[i].date), int.parse(data[i].dailyrecovered)));
      }
      /* for (var i = 0; i < dailyconfirmed.length; i++) {
        var x = dailyconfirmed[i].date.millisecondsSinceEpoch;

        var y = DateTime.fromMillisecondsSinceEpoch(x * 1000);
        var formattedDate = DateFormat.yMMMd().format(y);
        print(formattedDate);
      } */

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
              return value == null ? '-' : ' :  $value';
            },
            /*  secondaryMeasureFormatter: (num value){
              return value==null?'-':'$value';
            } */
          ),
          new charts.SelectNearest(),
          new charts.DomainHighlighter()
        ],
        defaultRenderer: charts.LineRendererConfig(
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
