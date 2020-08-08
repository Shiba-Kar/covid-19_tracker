
import 'package:covid_19/screens/page_holder.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(new MyApp());

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
      ),
      home: PageHolder(),
    );
  }
}
