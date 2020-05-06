import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
import 'package:covid_19/widgets/CountryHistoryStatistics.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class DetailedCountryScreen extends StatefulWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  const DetailedCountryScreen({@required this.covidDataCountriesModel, Key key})
      : super(key: key);

  @override
  _DetailedCountryScreenState createState() => _DetailedCountryScreenState();
}

class _DetailedCountryScreenState extends State<DetailedCountryScreen> {
  int _pastRecords = 10;

  @override
  Widget build(BuildContext context) {
    final ApiCall _apiCall = ApiCall();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        
        elevation: 0.0,
        title: Text(widget.covidDataCountriesModel.country),
        backgroundColor: mC,
      ),
      body: ListView(
        children: <Widget>[
          CountryCard(
            covidDataCountriesModel: widget.covidDataCountriesModel,
          ),
          Container(
            height: height / 1.6,
            child: CountryHistoryStatistics(
              country: widget.covidDataCountriesModel.country,
            ),
          ),
        ],
      ),
    );
    
  }
 
}
