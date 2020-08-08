import 'package:covid_19/models/covid_data_indian_model.dart';
import 'package:covid_19/services/api_call.dart';
import 'package:covid_19/widgets/Nm_box.dart';
import 'package:covid_19/widgets/loading_indicator.dart';
import 'package:covid_19/widgets/state_card.dart';
import 'package:flutter/material.dart';

class IndianStatesCovidPage extends StatefulWidget {
  IndianStatesCovidPage({Key key}) : super(key: key);

  @override
  _IndianStatesCovidPageState createState() => _IndianStatesCovidPageState();
}

class _IndianStatesCovidPageState extends State<IndianStatesCovidPage> {
  final ApiCall _apiCall = ApiCall();
  List<Statewise> data = [];
  @override
  Widget build(BuildContext context) {
    Widget error(error) {
      return Center(
        child: Text(error),
      );
    }

    Widget done() {
      data.removeAt(0);
      return Container(
        child: Scrollbar(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: StateCard(
                  tapable: true,
                  stateWise: data[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: mC,
      appBar: AppBar(
        title: Text("Indian States"),
        centerTitle: true,
        actions: <Widget>[
          Container(
              child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchStates(stateDistrict: data),
            ).then((value) => print(value.country)),
          ))
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: _apiCall.getIndianData(),
            builder: (BuildContext context,
                AsyncSnapshot<CovidDataIndianModel> snapshot) {
              if (snapshot.hasError) {
                return error(snapshot.error);
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return Container();
                    break;
                  case ConnectionState.done:
                    data = snapshot.data.statewise;
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
                      child: Text("In Default"),
                    );
                }
              }
            }),
      ),
    );
  }
}

class SearchStates extends SearchDelegate {
  final List<Statewise> stateDistrict;
  SearchStates({@required this.stateDistrict});

  List<Statewise> filteredList = [];
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
    // TODO: implement buildResults
    return Container();
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
      List<Statewise> x = stateDistrict.where((element) {
        return element.state.toLowerCase().startsWith(query.toLowerCase());
      }).toList();
      filteredList = x;

      return Container(
        child: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (BuildContext context, int index) {
            return StateCard(
              tapable: true,
              index: index,
              stateWise: filteredList[index],
            );
          },
        ),
      );
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          }),
     // IconButton(icon: Icon(Icons.mic), onPressed: () {})
    ];
  }
}
