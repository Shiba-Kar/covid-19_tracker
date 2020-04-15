import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GlobalCovidPage extends StatefulWidget {
  GlobalCovidPage({Key key}) : super(key: key);

  @override
  _GlobalCovidPageState createState() => _GlobalCovidPageState();
}

class _GlobalCovidPageState extends State<GlobalCovidPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final CovidDataAllModel _covidDataAllModel =
        Provider.of<CovidDataAllModel>(context);
    final List<CovidDataCountriesModel> _covidDataCountriesModel =
        Provider.of<List<CovidDataCountriesModel>>(context);
    Widget dataIsPresent() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Live Global Statistics",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
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
                  CustomCard(
                    title: "CASES",
                    subtitle: _covidDataAllModel.cases.toString(),
                    color: Colors.yellow,
                  ),
                  CustomCard(
                    title: "ACTIVE",
                    subtitle: _covidDataAllModel.active.toString(),
                    color: Colors.blue,
                  ),
                  CustomCard(
                      title: "RECOVERED",
                      subtitle: _covidDataAllModel.recovered.toString(),
                      color: Colors.green),
                  CustomCard(
                      title: "DEATHS",
                      subtitle: _covidDataAllModel.deaths.toString(),
                      color: Colors.red)
                ],
              ),
            ),
            Text(
              "Worst affected Countries",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            Container(
              height: height / 3,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CountryCard(
                      covidDataCountriesModel: _covidDataCountriesModel[index]);
                },
              ),
            )
          ],
        ),
      );
    }

    Widget dataIsBeingFeteced() {
      return Center(
        child: Container(
          child: SpinKitCircle(
            itemBuilder: (context, index) => CircleAvatar(),
          ),
        ),
      );
    }

    return _covidDataAllModel != null ? dataIsPresent() : dataIsBeingFeteced();
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  const CustomCard(
      {@required this.color,
      @required this.title,
      @required this.subtitle,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: nMbox,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 30.0, color: color),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 30.0, color: Colors.white30),
          )
        ],
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final CovidDataCountriesModel covidDataCountriesModel;
  const CountryCard({@required this.covidDataCountriesModel, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget text(String text, Color color) {
      return Text(
        text,
        style: TextStyle(color: color, fontSize: 13.0),
      );
    }

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width / 1.2,
                decoration: nMbox,
                child: ListTile(
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      text("CASES : "+covidDataCountriesModel.cases.toString(),
                          Colors.yellow),
                      text("ACTIVE : "+covidDataCountriesModel.active.toString(),
                          Colors.blue),
                      text("RECOVERED : "+covidDataCountriesModel.recovered.toString(),
                          Colors.green),
                      text("DEATH : "+covidDataCountriesModel.deaths.toString(),
                          Colors.red),
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    covidDataCountriesModel.country,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: width / 15,
              backgroundImage:
                  NetworkImage(covidDataCountriesModel.countryInfo.flag),
            ),
          ],
        ));
  }
}
