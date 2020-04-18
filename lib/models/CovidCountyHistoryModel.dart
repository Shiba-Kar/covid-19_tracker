// To parse this JSON data, do
//
//     final covidCountyHistoryModel = covidCountyHistoryModelFromJson(jsonString);

import 'dart:convert';

CovidCountyHistoryModel covidCountyHistoryModelFromJson(String str) => CovidCountyHistoryModel.fromJson(json.decode(str));

String covidCountyHistoryModelToJson(CovidCountyHistoryModel data) => json.encode(data.toJson());

class CovidCountyHistoryModel {
    String country;
    List<String> provinces;
    Timeline timeline;

    CovidCountyHistoryModel({
        this.country,
        this.provinces,
        this.timeline,
    });

    factory CovidCountyHistoryModel.fromJson(Map<String, dynamic> json) => CovidCountyHistoryModel(
        country: json["country"],
        provinces: List<String>.from(json["provinces"].map((x) => x)),
        timeline: Timeline.fromJson(json["timeline"]),
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "provinces": List<dynamic>.from(provinces.map((x) => x)),
        "timeline": timeline.toJson(),
    };
}

class Timeline {
    Map<String, int> cases;
    Map<String, int> deaths;
    Map<String, int> recovered;

    Timeline({
        this.cases,
        this.deaths,
        this.recovered,
    });

    factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        cases: Map.from(json["cases"]).map((k, v) => MapEntry<String, int>(k, v)),
        deaths: Map.from(json["deaths"]).map((k, v) => MapEntry<String, int>(k, v)),
        recovered: Map.from(json["recovered"]).map((k, v) => MapEntry<String, int>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "cases": Map.from(cases).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "deaths": Map.from(deaths).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "recovered": Map.from(recovered).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
