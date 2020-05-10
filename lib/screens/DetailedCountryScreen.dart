import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
import 'package:covid_19/widgets/CountryHistoryStatistics.dart';
import 'package:covid_19/widgets/CustomGridCard.dart';
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
    final countryName=widget.covidDataCountriesModel.country;
    
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        
        elevation: 0.0,
        title: Text(countryName),
        backgroundColor: mC,
      ),
      body: ListView(
        children: <Widget>[
          CountryCard(
            tapable: false,
            covidDataCountriesModel: widget.covidDataCountriesModel,
          ),
           Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "More Information",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          Container(
                padding: const EdgeInsets.all(0.0),
                height: height / 2,
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
                      title: "Cases/1M",
                      end: widget.covidDataCountriesModel.casesPerOneMillion.toDouble(),
                      color: Colors.yellow,
                      showChange: false,
                      
                    ),
                    CustomGridCard(
                      title: "Deaths/1M",
                      end: widget.covidDataCountriesModel.deathsPerOneMillion.toDouble(),
                      color: Colors.redAccent,
                      showChange: false,
                    ),
                   CustomGridCard(
                      title: "Critical",
                      end: widget.covidDataCountriesModel.critical.toDouble(),
                      color: Colors.orange,
                      showChange: false,
                    ),
                    CustomGridCard(
                      title: "Tests",
                      end: widget.covidDataCountriesModel.tests.toDouble(),
                      color: Colors.green,
                      showChange: false,
                    ),
                    CustomGridCard(
                      title: "Tests/1M",
                      end: widget.covidDataCountriesModel.testsPerOneMillion.toDouble(),
                      color: Colors.blue,
                      showChange: false,
                    ),
                     
                  ],
                ),
              ),
           Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$countryName History",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          Container(
            decoration: nMbox,
            margin: const EdgeInsets.all(30.0),
            height: height / 1.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CountryHistoryStatistics(
                country: widget.covidDataCountriesModel.country,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
 
}
