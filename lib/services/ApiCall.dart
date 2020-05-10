import 'dart:async';
import 'dart:io';

import 'package:async_resource/file_resource.dart';
import 'package:covid_19/models/CovidCountyHistoryModel.dart';
//import 'package:covid_19/models/CovidCountyModel.dart';
import 'package:covid_19/models/CovidDataAllModel.dart';
import 'package:covid_19/models/CovidDataCountriesModel.dart';
import 'package:covid_19/models/CovidDataIndianModel.dart';
import 'package:covid_19/models/StateDistrictCovidDataModel.dart';
import 'package:path_provider/path_provider.dart';

class ApiCall {
  Future<List<CovidDataCountriesModel>> getFilteredCountries(
      {String filter}) async {
    String path = ((await getTemporaryDirectory()).path);

    String _urlCovidCountries = filter != null
        ? "https://corona.lmao.ninja/v2/countries?sort=$filter"
        : "https://corona.lmao.ninja/v2/countries?sort=cases";

    try {
      final myDataResource = HttpNetworkResource<List<CovidDataCountriesModel>>(
        url: _urlCovidCountries,
        parser: (contents) => covidDataCountriesModelFromJson(contents),
        cache: FileResource(File('$path/$filter.json')),
        maxAge: Duration(minutes: 8),
        strategy: CacheStrategy.cacheFirst,
      );
      return myDataResource.get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CovidDataIndianModel> getIndianData() async {
    String path = ((await getTemporaryDirectory()).path);

    String _urlIndian = "https://api.covid19india.org/data.json";

    try {
      final myDataResource = HttpNetworkResource<CovidDataIndianModel>(
        url: _urlIndian,
        parser: (contents) => covidDataIndianModelFromJson(contents),
        cache: FileResource(File('$path/indianData.json')),
        maxAge: Duration(minutes: 8),
        strategy: CacheStrategy.cacheFirst,
      );
      return myDataResource.get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<DistrictDatum>> getDistricts(String stateCode) async {
    String path = ((await getTemporaryDirectory()).path);

    String _urlIndian ="https://api.covid19india.org/v2/state_district_wise.json";

    List<DistrictDatum> filteredList = [];

    try {
      final myDataResource =HttpNetworkResource<List<StateDistrictCovidDataModel>>(
        url: _urlIndian,
        parser: (contents) => stateDistrictCovidDataModelFromJson(contents),
        cache: FileResource(File('$path/state_district.json')),
        maxAge: Duration(minutes: 8),
        strategy: CacheStrategy.cacheFirst,
      );
      var x = await myDataResource.get();

      var y = x.where((element) => element.statecode.startsWith(stateCode)).toList();
      for (var item in y[0].districtData) {
        filteredList.add(item);
      }

      return filteredList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CovidDataAllModel> getCovidDataGolobal() async {
    String _urlCovidAll = "https://corona.lmao.ninja/v2/all?yesterday=false";
    String path = ((await getTemporaryDirectory()).path);
    try {
      final myDataResource = HttpNetworkResource<CovidDataAllModel>(
        url: _urlCovidAll,
        parser: (contents) => covidDataAllModelFromJson(contents),
        cache: FileResource(File('$path/allCountries.json')),
        maxAge: Duration(minutes: 8),
        strategy: CacheStrategy.cacheFirst,
      );
      return myDataResource.get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CovidCountyHistoryModel> getHistoricalData(
      {String country, int pastRecords}) async {
    String url =
        "https://corona.lmao.ninja/v2/historical/$country?lastdays=$pastRecords";
    String path = ((await getTemporaryDirectory()).path);
    try {
      final myDataResource = HttpNetworkResource<CovidCountyHistoryModel>(
        url: url,
        parser: (contents) => covidCountyHistoryModelFromJson(contents),
        cache: FileResource(File('$path/history_$country.json')),
        maxAge: Duration(minutes: 8),
        strategy: CacheStrategy.networkFirst,
      );
      return myDataResource.get();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
