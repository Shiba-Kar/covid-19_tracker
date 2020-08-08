import 'package:covid_19/models/state_district_covid_data_model.dart';
import 'package:covid_19/services/api_call.dart';
import 'package:covid_19/widgets/district_card.dart';
import 'package:covid_19/widgets/loading_indicator.dart';
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
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            print(data.length);
            return DistrictCard(
              index: index,
              district: data[index],
            );
          },
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
