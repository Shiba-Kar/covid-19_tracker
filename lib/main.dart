import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/PageHolder.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ApiCall _apiCall = ApiCall();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<CovidDataCountriesModel>>.value(
            value: _apiCall.streamCovidDataCountries),
        StreamProvider<CovidDataAllModel>.value(
            value: _apiCall.streamCovidDataAll)
      ],
      child: MaterialApp(
        title: 'COVID-19 States',
        theme: ThemeData(
          fontFamily: 'VarelaRound',
         
         // primaryColor: Color(0xFF757575),
         // accentColor: Color(0x00FFFFFF),
         // canvasColor: Color(0xFF757575),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PageHolder(),
      ),
    );
  }
}
