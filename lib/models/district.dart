import 'dart:convert';

Districts districtsFromJson(String str) => Districts.fromJson(json.decode(str));

String districtsToJson(Districts data) => json.encode(data.toJson());

class Districts {
  Districts({
    this.districts,
    this.ttl,
  });

  List<District> districts;
  int ttl;

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
        ttl: json["ttl"],
      );

  Map<String, dynamic> toJson() => {
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
        "ttl": ttl,
      };
}

class District {
  District({
    this.districtId,
    this.districtName,
  });

  int districtId;
  String districtName;

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        districtName: json["district_name"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
      };
}
