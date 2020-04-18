import 'dart:async';

import 'package:covid_19/models/CovidCountyHistoryModel.dart';
import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:http/http.dart';

class ApiCall {
  static const String _urlCovidCountries =
      "https://corona.lmao.ninja/v2/countries?sort=cases";
  static const String _urlCovidAll = "https://corona.lmao.ninja/v2/all";

  final _client = Client();
  var _streamControllerCountries =
      StreamController<List<CovidDataCountriesModel>>();
  var _streamControllerAll = StreamController<CovidDataAllModel>();
  ApiCall() {
    _getCovidDataCountries();
    _getCovidDataAll();
    Timer.periodic(Duration(minutes: 2), (t) {
      _getCovidDataCountries();
      _getCovidDataAll();
    });
  }
  Future _getCovidDataCountries() async {
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

  Future _getCovidDataAll() async {
    try {
      var response = await _client.get(_urlCovidAll);
      CovidDataAllModel x = covidDataAllModelFromJson(response.body);
      _streamControllerAll.add(x);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CovidCountyHistoryModel> _getHistoricalData(String country) async {
    try {
      var response = await _client
          .get('https://corona.lmao.ninja/v2/historical/$country?lastdays=30');
      CovidCountyHistoryModel x =
          covidCountyHistoryModelFromJson(response.body);
      return x;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Stream<List<CovidDataCountriesModel>> get streamCovidDataCountries =>
      _streamControllerCountries.stream;

  Stream<CovidDataAllModel> get streamCovidDataAll =>
      _streamControllerAll.stream;

  Future<CovidCountyHistoryModel> getHistoricalData(String country) =>
      _getHistoricalData(country);
}
