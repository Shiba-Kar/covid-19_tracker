//     final covid19ResourcesModel = covid19ResourcesModelFromJson(jsonString);

import 'dart:convert';

Covid19ResourcesModel covid19ResourcesModelFromJson(String str) =>
    Covid19ResourcesModel.fromJson(json.decode(str));

String covid19ResourcesModelToJson(Covid19ResourcesModel data) =>
    json.encode(data.toJson());

class Covid19ResourcesModel {
  List<Resource> resources;

  Covid19ResourcesModel({
    this.resources,
  });

  factory Covid19ResourcesModel.fromJson(Map<String, dynamic> json) =>
      Covid19ResourcesModel(
        resources: List<Resource>.from(
            json["resources"].map((x) => Resource.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resources": List<dynamic>.from(resources.map((x) => x.toJson())),
      };
}

class Resource {
  Category category;
  String city;
  String contact;
  String descriptionandorserviceprovided;
  String nameoftheorganisation;
  String phonenumber;
  State state;

  Resource({
    this.category,
    this.city,
    this.contact,
    this.descriptionandorserviceprovided,
    this.nameoftheorganisation,
    this.phonenumber,
    this.state,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        category: categoryValues.map[json["category"]],
        city: json["city"],
        contact: json["contact"],
        descriptionandorserviceprovided:
            json["descriptionandorserviceprovided"],
        nameoftheorganisation: json["nameoftheorganisation"],
        phonenumber: json["phonenumber"],
        state: stateValues.map[json["state"]],
      );

  Map<String, dynamic> toJson() => {
        "category": categoryValues.reverse[category],
        "city": city,
        "contact": contact,
        "descriptionandorserviceprovided": descriptionandorserviceprovided,
        "nameoftheorganisation": nameoftheorganisation,
        "phonenumber": phonenumber,
        "state": stateValues.reverse[state],
      };
}

enum Category {
  CO_VID_19_TESTING_LAB,
  FREE_FOOD,
  FUNDRAISERS,
  HOSPITALS_AND_CENTERS,
  DELIVERY_VEGETABLES_FRUITS_GROCERIES_MEDICINES_ETC,
  POLICE,
  GOVERNMENT_HELPLINE,
  OTHER,
  MENTAL_WELL_BEING_AND_EMOTIONAL_SUPPORT,
  ACCOMMODATION_AND_SHELTER_HOMES,
  SENIOR_CITIZEN_SUPPORT,
  TRANSPORTATION,
  COMMUNITY_KITCHEN,
  AMBULANCE,
  FIRE_BRIGADE,
  QUARANTINE_FACILITY
}

final categoryValues = EnumValues({
  "Accommodation and Shelter Homes": Category.ACCOMMODATION_AND_SHELTER_HOMES,
  "Ambulance": Category.AMBULANCE,
  "Community Kitchen": Category.COMMUNITY_KITCHEN,
  "CoVID-19 Testing Lab": Category.CO_VID_19_TESTING_LAB,
  "Delivery [Vegetables, Fruits, Groceries, Medicines, etc.]":
      Category.DELIVERY_VEGETABLES_FRUITS_GROCERIES_MEDICINES_ETC,
  "Fire Brigade": Category.FIRE_BRIGADE,
  "Free Food": Category.FREE_FOOD,
  "Fundraisers": Category.FUNDRAISERS,
  "Government Helpline": Category.GOVERNMENT_HELPLINE,
  "Hospitals and Centers": Category.HOSPITALS_AND_CENTERS,
  "Mental well being and Emotional Support":
      Category.MENTAL_WELL_BEING_AND_EMOTIONAL_SUPPORT,
  "Other": Category.OTHER,
  "Police": Category.POLICE,
  "Quarantine Facility": Category.QUARANTINE_FACILITY,
  "Senior Citizen Support": Category.SENIOR_CITIZEN_SUPPORT,
  "Transportation": Category.TRANSPORTATION
});

enum State {
  ANDAMAN_NICOBAR,
  ANDHRA_PRADESH,
  ASSAM,
  BIHAR,
  CHANDIGARH,
  CHHATTISGARH,
  DELHI,
  GOA,
  GUJARAT,
  HARYANA,
  HIMACHAL_PRADESH,
  JAMMU_KASHMIR,
  JHARKHAND,
  KARNATAKA,
  KERALA,
  MADHYA_PRADESH,
  MAHARASHTRA,
  MANIPUR,
  MEGHALAYA,
  ODISHA,
  PAN_INDIA,
  PUDUCHERRY,
  PUNJAB,
  RAJASTHAN,
  TAMIL_NADU,
  TELANGANA,
  UTTAR_PRADESH,
  WEST_BENGAL,
  SIKKIM,
  TRIPURA,
  UTTARAKHAND
}

final stateValues = EnumValues({
  "Andaman & Nicobar": State.ANDAMAN_NICOBAR,
  "Andhra Pradesh": State.ANDHRA_PRADESH,
  "Assam": State.ASSAM,
  "Bihar": State.BIHAR,
  "Chandigarh": State.CHANDIGARH,
  "Chhattisgarh": State.CHHATTISGARH,
  "Delhi": State.DELHI,
  "Goa": State.GOA,
  "Gujarat": State.GUJARAT,
  "Haryana": State.HARYANA,
  "Himachal Pradesh": State.HIMACHAL_PRADESH,
  "Jammu & Kashmir": State.JAMMU_KASHMIR,
  "Jharkhand": State.JHARKHAND,
  "Karnataka": State.KARNATAKA,
  "Kerala": State.KERALA,
  "Madhya Pradesh": State.MADHYA_PRADESH,
  "Maharashtra": State.MAHARASHTRA,
  "Manipur": State.MANIPUR,
  "Meghalaya": State.MEGHALAYA,
  "Odisha": State.ODISHA,
  "PAN India": State.PAN_INDIA,
  "Puducherry": State.PUDUCHERRY,
  "Punjab": State.PUNJAB,
  "Rajasthan": State.RAJASTHAN,
  "Sikkim": State.SIKKIM,
  "Tamil Nadu": State.TAMIL_NADU,
  "Telangana": State.TELANGANA,
  "Tripura": State.TRIPURA,
  "Uttarakhand": State.UTTARAKHAND,
  "Uttar Pradesh": State.UTTAR_PRADESH,
  "West Bengal": State.WEST_BENGAL
});

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
