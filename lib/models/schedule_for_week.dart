import 'dart:convert';

ScheduleForWeek scheduleForWeekFromJson(String str) =>
    ScheduleForWeek.fromJson(json.decode(str));

String scheduleForWeekToJson(ScheduleForWeek data) =>
    json.encode(data.toJson());

class ScheduleForWeek {
  ScheduleForWeek({
    this.centers,
  });

  List<Center> centers;

  factory ScheduleForWeek.fromJson(Map<String, dynamic> json) =>
      ScheduleForWeek(
        centers:
            List<Center>.from(json["centers"].map((x) => Center.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "centers": List<dynamic>.from(centers.map((x) => x.toJson())),
      };
}

class Center {
  Center({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pincode,
    this.lat,
    this.long,
    this.from,
    this.to,
    this.feeType,
    this.sessions,
    this.vaccineFees,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  int pincode;
  int lat;
  int long;
  String from;
  String to;
  String feeType;
  List<Session> sessions;
  List<VaccineFee> vaccineFees;

  factory Center.fromJson(Map<String, dynamic> json) => Center(
        centerId: json["center_id"],
        name: json["name"],
        address: json["address"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        blockName: json["block_name"],
        pincode: json["pincode"],
        lat: json["lat"],
        long: json["long"],
        from: json["from"],
        to: json["to"],
        feeType: json["fee_type"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
        vaccineFees: json["vaccine_fees"] == null
            ? null
            : List<VaccineFee>.from(
                json["vaccine_fees"].map((x) => VaccineFee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "center_id": centerId,
        "name": name,
        "address": address,
        "state_name": stateName,
        "district_name": districtName,
        "block_name": blockName,
        "pincode": pincode,
        "lat": lat,
        "long": long,
        "from": from,
        "to": to,
        "fee_type": feeType,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "vaccine_fees": vaccineFees == null
            ? null
            : List<dynamic>.from(vaccineFees.map((x) => x.toJson())),
      };
}

class Session {
  Session({
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.minAgeLimit,
    this.vaccine,
    this.slots,
  });

  String sessionId;
  String date;
  int availableCapacity;
  int minAgeLimit;
  String vaccine;
  List<String> slots;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json["session_id"],
        date: json["date"],
        availableCapacity: json["available_capacity"].toInt(),
        minAgeLimit: json["min_age_limit"],
        vaccine: json["vaccine"],
        slots: List<String>.from(json["slots"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "date": date,
        "available_capacity": availableCapacity,
        "min_age_limit": minAgeLimit,
        "vaccine": vaccine,
        "slots": List<dynamic>.from(slots.map((x) => x)),
      };
}

class VaccineFee {
  VaccineFee({
    this.vaccine,
    this.fee,
  });

  String vaccine;
  String fee;

  factory VaccineFee.fromJson(Map<String, dynamic> json) => VaccineFee(
        vaccine: json["vaccine"],
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "vaccine": vaccine,
        "fee": fee,
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
