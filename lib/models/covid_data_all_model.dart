import 'dart:convert';

CovidDataAllModel covidDataAllModelFromJson(String str) => CovidDataAllModel.fromJson(json.decode(str));

String covidDataAllModelToJson(CovidDataAllModel data) => json.encode(data.toJson());

class CovidDataAllModel {
  int updated;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  double deathsPerOneMillion;
  int tests;
  double testsPerOneMillion;
  int population;
  double activePerOneMillion;
  double recoveredPerOneMillion;
  double criticalPerOneMillion;
  int affectedCountries;

  CovidDataAllModel(
      {this.updated,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.population,
      this.activePerOneMillion,
      this.recoveredPerOneMillion,
      this.criticalPerOneMillion,
      this.affectedCountries});

  CovidDataAllModel.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    active = json['active'];
    critical = json['critical'];
    casesPerOneMillion = json['casesPerOneMillion'];
    deathsPerOneMillion = json['deathsPerOneMillion'];
    tests = json['tests'];
    testsPerOneMillion = json['testsPerOneMillion'];
    population = json['population'];
    activePerOneMillion = json['activePerOneMillion'];
    recoveredPerOneMillion = json['recoveredPerOneMillion'];
    criticalPerOneMillion = json['criticalPerOneMillion'];
    affectedCountries = json['affectedCountries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['tests'] = this.tests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    data['population'] = this.population;
    data['activePerOneMillion'] = this.activePerOneMillion;
    data['recoveredPerOneMillion'] = this.recoveredPerOneMillion;
    data['criticalPerOneMillion'] = this.criticalPerOneMillion;
    data['affectedCountries'] = this.affectedCountries;
    return data;
  }
}
