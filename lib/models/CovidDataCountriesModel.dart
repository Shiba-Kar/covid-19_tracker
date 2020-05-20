// To parse this JSON data, do
//
//     final covidDataCountriesModel = covidDataCountriesModelFromJson(jsonString);

import 'dart:convert';

List<CovidDataCountriesModel> covidDataCountriesModelFromJson(String str) => List<CovidDataCountriesModel>.from(json.decode(str).map((x) => CovidDataCountriesModel.fromJson(x)));

String covidDataCountriesModelToJson(List<CovidDataCountriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CovidDataCountriesModel {
    int updated;
    String country;
    CountryInfo countryInfo;
    int cases;
    int todayCases;
    int deaths;
    int todayDeaths;
    int recovered;
    int active;
    int critical;
    double casesPerOneMillion;
    double deathsPerOneMillion;
    int tests;
    int testsPerOneMillion;
    int population;
    Continent continent;
    double activePerOneMillion;
    double recoveredPerOneMillion;
    double criticalPerOneMillion;

    CovidDataCountriesModel({
        this.updated,
        this.country,
        this.countryInfo,
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
        this.continent,
        this.activePerOneMillion,
        this.recoveredPerOneMillion,
        this.criticalPerOneMillion,
    });

    factory CovidDataCountriesModel.fromJson(Map<String, dynamic> json) => CovidDataCountriesModel(
        updated: json["updated"],
        country: json["country"],
        countryInfo: CountryInfo.fromJson(json["countryInfo"]),
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"].toDouble(),
        deathsPerOneMillion: json["deathsPerOneMillion"].toDouble(),
        tests: json["tests"],
        testsPerOneMillion: json["testsPerOneMillion"],
        population: json["population"],
        continent: continentValues.map[json["continent"]],
        activePerOneMillion: json["activePerOneMillion"].toDouble(),
        recoveredPerOneMillion: json["recoveredPerOneMillion"].toDouble(),
        criticalPerOneMillion: json["criticalPerOneMillion"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "updated": updated,
        "country": country,
        "countryInfo": countryInfo.toJson(),
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
        "tests": tests,
        "testsPerOneMillion": testsPerOneMillion,
        "population": population,
        "continent": continentValues.reverse[continent],
        "activePerOneMillion": activePerOneMillion,
        "recoveredPerOneMillion": recoveredPerOneMillion,
        "criticalPerOneMillion": criticalPerOneMillion,
    };
}

enum Continent { NORTH_AMERICA, EUROPE, SOUTH_AMERICA, ASIA, AFRICA, AUSTRALIA_OCEANIA, EMPTY }

final continentValues = EnumValues({
    "Africa": Continent.AFRICA,
    "Asia": Continent.ASIA,
    "Australia/Oceania": Continent.AUSTRALIA_OCEANIA,
    "": Continent.EMPTY,
    "Europe": Continent.EUROPE,
    "North America": Continent.NORTH_AMERICA,
    "South America": Continent.SOUTH_AMERICA
});

class CountryInfo {
    int id;
    String iso2;
    String iso3;
    double lat;
    double long;
    String flag;

    CountryInfo({
        this.id,
        this.iso2,
        this.iso3,
        this.lat,
        this.long,
        this.flag,
    });

    factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
        id: json["_id"] == null ? null : json["_id"],
        iso2: json["iso2"] == null ? null : json["iso2"],
        iso3: json["iso3"] == null ? null : json["iso3"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "iso2": iso2 == null ? null : iso2,
        "iso3": iso3 == null ? null : iso3,
        "lat": lat,
        "long": long,
        "flag": flag,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
