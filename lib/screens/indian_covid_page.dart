import 'package:covid_19/models/covid_data_indian_model.dart';
import 'package:covid_19/services/api_call.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:covid_19/widgets/custom_grid_card.dart';
import 'package:covid_19/widgets/indian_statistics_line_chart_daily.dart';
import 'package:covid_19/widgets/indian_statistics_line_chart_total.dart';
import 'package:covid_19/widgets/loading_indicator.dart';
import 'package:covid_19/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
      Widget updatedTime() {
        String date = data.statewise[0].lastupdatedtime;

        var formattedDate = DateFormat('dd/MM/yyyy').parse(date);

        return Text("Updated on " + DateFormat.yMMMd().format(formattedDate));
      }

      return ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Live Indian Statistics",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
                updatedTime()
              ],
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
                CustomGridCard(
                  showChange: true,
                  title: "CASES",
                  end: double.parse(data.statewise[0].confirmed),
                  color: Colors.yellow,
                  changeValue: data.statewise[0].deltaconfirmed,
                ),
                CustomGridCard(
                  showChange: false,
                  title: "ACTIVE",
                  end: double.parse(data.statewise[0].active),
                  color: Colors.blue,
                ),
                CustomGridCard(
                  showChange: true,
                  title: "RECOVERED",
                  end: double.parse(data.statewise[0].recovered),
                  color: Colors.green,
                  changeValue: data.statewise[0].deltarecovered,
                ),
                CustomGridCard(
                  showChange: true,
                  title: "DEATHS",
                  end: double.parse(data.statewise[0].deaths),
                  color: Colors.red,
                  changeValue: data.statewise[0].deltadeaths,
                )
              ],
            ),
          ),
          Center(
            child: Text(
              "Daily Statistics",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ),
          Container(
            height: height / 1.8,
          // margin: const EdgeInsets.all(10.0),
            child: ListView(
              physics: ScrollPhysics(parent: ScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(30.0),
                  decoration: nMbox,
                  height: height / 1,
                  width: width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IndianStatisticsLineChartDaily(
                      indianCovidDataModel: data,
                    ),
                  ),
                ),
                Container(
                  decoration: nMbox,
                  margin: const EdgeInsets.all(30.0),
                  height: height / 1,
                  width: width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IndianStatisticsLineChartTotal(
                      indianCovidDataModel: data,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Worst Affected States",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
          Container(
            width: width,
            height: height / 2.6,
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                List<Statewise> statewise = data.statewise;
                statewise.removeAt(0);
                return StateCard(
                  tapable: true,
                  stateWise: statewise[index],
                  index: index,
                );
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
