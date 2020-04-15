// To parse this JSON data, do
//
//     final covidDataAllModel = covidDataAllModelFromJson(jsonString);

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
    int deathsPerOneMillion;

    CovidDataAllModel({
        this.updated,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion,
    });

    factory CovidDataAllModel.fromJson(Map<String, dynamic> json) => CovidDataAllModel(
        updated: json["updated"],
        cases: json["cases"],
        todayCases: json["todayCases"],
        deaths: json["deaths"],
        todayDeaths: json["todayDeaths"],
        recovered: json["recovered"],
        active: json["active"],
        critical: json["critical"],
        casesPerOneMillion: json["casesPerOneMillion"],
        deathsPerOneMillion: json["deathsPerOneMillion"],
    );

    Map<String, dynamic> toJson() => {
        "updated": updated,
        "cases": cases,
        "todayCases": todayCases,
        "deaths": deaths,
        "todayDeaths": todayDeaths,
        "recovered": recovered,
        "active": active,
        "critical": critical,
        "casesPerOneMillion": casesPerOneMillion,
        "deathsPerOneMillion": deathsPerOneMillion,
    };
}
