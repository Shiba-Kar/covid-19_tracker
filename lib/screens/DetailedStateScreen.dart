import 'package:covid_19/models/StateDistrictCovidDataModel.dart';
import 'package:flutter/material.dart';

class DetailedStateScreen extends StatefulWidget {
  final StateDistrictCovidDataModel stateDistrictCovidDataModel;
  DetailedStateScreen({@required this.stateDistrictCovidDataModel, Key key})
      : super(key: key);

  @override
  _DetailedStateScreenState createState() => _DetailedStateScreenState();
}

class _DetailedStateScreenState extends State<DetailedStateScreen> {
  @override
  Widget build(BuildContext context) {
    final district=widget.stateDistrictCovidDataModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(district.state),
      ),
      body: Container(
        child: ListView.builder(
          itemCount:district.districtData.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(child: Text(district.districtData[index].active.toString()),);
         },
        ),
      ),
    );
  }
}
