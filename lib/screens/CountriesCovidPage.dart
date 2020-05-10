import 'package:covid_19/models/CovidDataCountriesModel.dart';

import 'package:covid_19/services/ApiCall.dart';
import 'package:covid_19/widgets/CountryCard.dart';
import 'package:covid_19/widgets/LoadingIndicator.dart';
import 'package:covid_19/widgets/NavButtons.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:flutter/material.dart';

class CountriesCovidPage extends StatefulWidget {
  CountriesCovidPage({Key key}) : super(key: key);

  @override
  _CountriesCovidPageState createState() => _CountriesCovidPageState();
}

class _CountriesCovidPageState extends State<CountriesCovidPage> {
  String _dropDownValue;
  final ApiCall _apiCall = ApiCall();
  List<DropdownMenuItem> _dropDownItems = [];
  List<CovidDataCountriesModel> data = [];
  final List<String> _dropDownValues = [
    "cases",
    "todayCases",
    "deaths",
    "todayDeaths",
    "recovered",
    "active",
    "critical",
    "casesPerOneMillion",
    "deathsPerOneMillion"
  ];

  void _poulateDropDown() {
    for (var item in _dropDownValues) {
      _dropDownItems.add(DropdownMenuItem(
        child: Text(item.toUpperCase()),
        value: item,
      ));
    }
  }

  @override
  void initState() {
    _poulateDropDown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget body() {
      Widget active() {
        return Container(
          child: Text("In Active state"),
        );
      }

      Widget done() {
        return Container(
          child: Scrollbar(
            child: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return CountryCard(
                  tapable: true,
                  covidDataCountriesModel: data[index],
                );
              },
            ),
          ),
        );
      }

      Widget error(Object error) {
        return Container(child: Center(child: Text(error.toString())));
      }

      return FutureBuilder(
        future: _apiCall.getFilteredCountries(filter: _dropDownValue),
        builder: (BuildContext context,
            AsyncSnapshot<List<CovidDataCountriesModel>> snapshot) {
          if (snapshot.hasError) {
            return error(snapshot.error);
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return active();
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
                  child: Text("In defult"),
                );
            }
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Filter By",
                  style: TextStyle(color: Colors.white),
                ),
                DropdownButton(
                  hint: Text(
                    "Cases",
                    style: TextStyle(color: Colors.white),
                  ),
                  // dropdownColor: mC,
                  isDense: false,
                  iconSize: 40.0,
                  underline: Container(),
                  style: TextStyle(color: Colors.white),
                  value: _dropDownValue,
                  items: _dropDownItems.map((e) => e).toList(),
                  onChanged: (value) => setState(
                    () => _dropDownValue = value,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            50.0,
          ),
        ),
        backgroundColor: mC,
        title: Text("Countries Statistics"),
        centerTitle: true,
        actions: <Widget>[
         
          Container(
            decoration:nMbox,
            margin: const EdgeInsets.all(7.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: SearchCountries(countries: data),
              ).then((value) => print(value.country)),
            ),
          )
        ],
      ),
      body: body(),
    );
  }
}

class SearchCountries extends SearchDelegate<CovidDataCountriesModel> {
  final List<CovidDataCountriesModel> countries;
  SearchCountries({@required this.countries});

  List<CovidDataCountriesModel> filteredList = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          }),
      IconButton(icon: Icon(Icons.mic), onPressed: () {})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: theme.primaryTextTheme.title.color,
        ),
      ),
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
      textTheme: theme.textTheme.copyWith(
        title: theme.textTheme.title.copyWith(
          color: theme.primaryTextTheme.title.color,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (query.isEmpty) {
      filteredList = [];
      return Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 50.0,
              color: Colors.white,
            ),
            Text("Start Typing..."),
          ],
        ),
      );
    } else {
      List<CovidDataCountriesModel> x = countries.where((element) {
        return element.country.toLowerCase().startsWith(query.toLowerCase());
      }).toList();
      filteredList = x;

      return Container(
        child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (BuildContext context, int index) {
              return CountryCard(
                tapable: true,
                covidDataCountriesModel: filteredList[index]);
            }),
      );
    }
  }

  @override
  void showResults(BuildContext context) {}

  @override
  void showSuggestions(BuildContext context) {}
}
