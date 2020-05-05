/* import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class SearchCountryTest extends StatefulWidget {
  SearchCountryTest({Key key}) : super(key: key);

  @override
  _SearchCountryTestState createState() => _SearchCountryTestState();
}

class _SearchCountryTestState extends State<SearchCountryTest> {
  final ApiCall _apiCall = ApiCall();
  List<CovidDataCountriesModel> data = [];
  @override
  Widget build(BuildContext context) {
    Widget done() {
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return CountryCard(covidDataCountriesModel: data[index]);
          });
    }

    return Scaffold(
     
      backgroundColor: mC,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchCountries(countries: data));
              })
        ],
      ),
      body: FutureBuilder(
          future: _apiCall.getFilteredCountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return Center(
                    child: Text("active"),
                  );
                  break;
                case ConnectionState.done:
                  data = snapshot.data;
                  return Center(
                    child: done(),
                  );
                  break;
                case ConnectionState.none:
                  return Center(
                    child: Text("none"),
                  );
                  break;
                case ConnectionState.waiting:
                  return LoadingIndicator();
                  break;
                default:
                  return Container();
              }
            }
          }),
    );
  }
}

 */