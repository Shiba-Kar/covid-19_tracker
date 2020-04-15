import 'dart:async';

import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:http/http.dart';

class ApiCall {
  static const String _urlCovidCountries =
      "https://corona.lmao.ninja/countries?sort=cases";
  static const String _urlCovidAll = "https://corona.lmao.ninja/all";

  final _client = Client();
  var _streamControllerCountries =
      StreamController<List<CovidDataCountriesModel>>();
  var _streamControllerAll = StreamController<CovidDataAllModel>();
  ApiCall() {
    Timer.periodic(Duration(seconds: 4), (t) {
      _getCovidDataCountries(t);
      _getCovidDataAll(t);
    });
  }
  Future _getCovidDataCountries(Timer t) async {
    try {
      var response = await _client.get(_urlCovidCountries);
      List<CovidDataCountriesModel> x =
          covidDataCountriesModelFromJson(response.body);
      _streamControllerCountries.add(x);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future _getCovidDataAll(Timer t) async {
    try {
      var response = await _client.get(_urlCovidAll);
      CovidDataAllModel x = covidDataAllModelFromJson(response.body);
      _streamControllerAll.add(x);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<CovidDataCountriesModel>> get streamCovidDataCountries =>
      _streamControllerCountries.stream;

  Stream<CovidDataAllModel> get streamCovidDataAll =>
      _streamControllerAll.stream;
}
