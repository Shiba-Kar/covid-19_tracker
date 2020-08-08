// To parse this JSON data, do
//
//     final stateDistrictCovidDataModel = stateDistrictCovidDataModelFromJson(jsonString);

import 'dart:convert';

List<StateDistrictCovidDataModel> stateDistrictCovidDataModelFromJson(
        String str) =>
    List<StateDistrictCovidDataModel>.from(
        json.decode(str).map((x) => StateDistrictCovidDataModel.fromJson(x)));

String stateDistrictCovidDataModelToJson(
        List<StateDistrictCovidDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateDistrictCovidDataModel {
  String state;
  String statecode;
  List<DistrictDatum> districtData;

  StateDistrictCovidDataModel({
    this.state,
    this.statecode,
    this.districtData,
  });

  factory StateDistrictCovidDataModel.fromJson(Map<String, dynamic> json) =>
      StateDistrictCovidDataModel(
        state: json["state"],
        statecode: json["statecode"],
        districtData: List<DistrictDatum>.from(
            json["districtData"].map((x) => DistrictDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "statecode": statecode,
        "districtData": List<dynamic>.from(districtData.map((x) => x.toJson())),
      };
}

class DistrictDatum {
  String district;
  String notes;
  int active;
  int confirmed;
  int deceased;
  int recovered;
  Delta delta;

  DistrictDatum({
    this.district,
    this.notes,
    this.active,
    this.confirmed,
    this.deceased,
    this.recovered,
    this.delta,
  });

  factory DistrictDatum.fromJson(Map<String, dynamic> json) => DistrictDatum(
        district: json["district"],
        notes: json["notes"],
        active: json["active"],
        confirmed: json["confirmed"],
        deceased: json["deceased"],
        recovered: json["recovered"],
        delta: Delta.fromJson(json["delta"]),
      );

  Map<String, dynamic> toJson() => {
        "district": district,
        "notes": notes,
        "active": active,
        "confirmed": confirmed,
        "deceased": deceased,
        "recovered": recovered,
        "delta": delta.toJson(),
      };
}

class Delta {
  int confirmed;
  int deceased;
  int recovered;

  Delta({
    this.confirmed,
    this.deceased,
    this.recovered,
  });

  factory Delta.fromJson(Map<String, dynamic> json) => Delta(
        confirmed: json["confirmed"],
        deceased: json["deceased"],
        recovered: json["recovered"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "deceased": deceased,
        "recovered": recovered,
      };
}
