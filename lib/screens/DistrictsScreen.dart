import 'package:covid_19/models/StateDistrictCovidDataModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/DistrictGridCard.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:flutter/material.dart';

class DistrictsScreen extends StatefulWidget {
  final String stateCode;
  final String state;
  DistrictsScreen({@required this.stateCode, @required this.state, Key key})
      : super(key: key);

  @override
  _DistrictsScreenState createState() => _DistrictsScreenState();
}

class _DistrictsScreenState extends State<DistrictsScreen> {
  final ApiCall _apiCall = ApiCall();
  List<DistrictDatum> data;
  @override
  Widget build(BuildContext context) {
    Widget error(error) {
      return Center(
        child: Text(error),
      );
    }

    final height = MediaQuery.of(context).size.height;

    Widget done() {
      return Scrollbar(
              child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  print(data.length);
                  return DistrictGridCard(
                    district: data[index],
                  );
                },
                childCount: data.length,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.state),
      ),
      body: Container(
        child: FutureBuilder(
            future: _apiCall.getDistricts(widget.stateCode),
            builder: (BuildContext context,
                AsyncSnapshot<List<DistrictDatum>> snapshot) {
              if (snapshot.hasError) {
                return error(snapshot.error);
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return Container();
                    break;
                  case ConnectionState.done:
                    data = snapshot.data;
                    return done();
                    break;
                  case ConnectionState.waiting:
                    return LoadingIndicator();
                    break;
                  case ConnectionState.none:
                    return LoadingIndicator();
                    break;
                  default:
                    return Container(
                      child: Text("In Default"),
                    );
                }
              }
            }),
      ),
    );
  }
}
