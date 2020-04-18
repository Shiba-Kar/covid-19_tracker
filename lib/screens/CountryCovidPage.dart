import 'package:avatar_glow/avatar_glow.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/screens/DetailedCountryScreen.dart';
import 'package:covid_19/widgets/GlowFlags.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCovidPage extends StatefulWidget {
  CountryCovidPage({Key key}) : super(key: key);

  @override
  _CountryCovidPageState createState() => _CountryCovidPageState();
}

class _CountryCovidPageState extends State<CountryCovidPage> {
  @override
  Widget build(BuildContext context) {
    final List<CovidDataCountriesModel> _covidDataCountriesModel =
        Provider.of<List<CovidDataCountriesModel>>(context);
    Widget dataisPresent() {
      return Container(
        child: Scrollbar(
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: _covidDataCountriesModel.length,
            itemBuilder: (BuildContext context, int index) {
              return CountryCard(
                covidDataCountry: _covidDataCountriesModel[index],
              );
            },
          ),
        ),
      );
    }

    return _covidDataCountriesModel != null
        ? dataisPresent()
        : LoadingIndicator();
  }
}

class CountryCard extends StatelessWidget {
  final CovidDataCountriesModel covidDataCountry;
  const CountryCard({@required this.covidDataCountry, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Widget text(String text, Color color) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0),
      );
    }

    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            width: width / 1.2,
            decoration: nMboxInvert,
            child: ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedCountryScreen(
                    covidDataCountriesModel: covidDataCountry,
                  ),
                ),
              ),
              isThreeLine: true,
              title: Text(
                covidDataCountry.country,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  text("CASES : " + covidDataCountry.cases.toString(),
                      Colors.yellow),
                  text("ACTIVE : " + covidDataCountry.active.toString(),
                      Colors.blue),
                  text("RECOVERED : " + covidDataCountry.recovered.toString(),
                      Colors.green),
                  text("DEATH : " + covidDataCountry.deaths.toString(),
                      Colors.red),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: GlowFlags(flagUrl: covidDataCountry.countryInfo.flag),
        ),
      ],
    );
  }
}
