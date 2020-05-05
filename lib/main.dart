import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/PageHolder.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//import 'package:syncfusion_flutter_core/core.dart';
void main() {
  // SyncfusionLicense.registerLicense("NT8mJyc2IWhia31ifWN9YGVoZ3xhZnxhY2Fjc2JiaWFiaWBjcwMeaCA7OjEyIyEyIDI3ODIhZmMTND4yOj99MDw+");

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey[850], elevation: 0.0),
        canvasColor: Colors.grey[850],
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Colors.white),
        backgroundColor: mC,
        primaryColor: Color(0xFF45413b),
        accentColor: Color(0x00FFFFFF),
        // canvasColor: Color(0xFF757575),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageHolder(),
    );
  }
}
