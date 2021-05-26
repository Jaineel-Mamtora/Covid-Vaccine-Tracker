class AvailableSlot {
  int centerId;
  String name;
  int pincode;
  String sessionId;
  String date;
  int availableCapacity;
  int minimumAgeLimit;
  String vaccine;
  String feeType;
  String slot;

  AvailableSlot({
    this.centerId,
    this.name,
    this.pincode,
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.minimumAgeLimit,
    this.feeType,
    this.vaccine,
    this.slot,
  });

  factory AvailableSlot.fromJson(Map<String, dynamic> json) => AvailableSlot(
        centerId: json['center_id'],
        name: json['name'],
        pincode: json['pincode'],
        sessionId: json['session_id'],
        date: json['date'],
        availableCapacity: json['available_capacity'],
        minimumAgeLimit: json['min_age_limit'],
        vaccine: json['vaccine'],
        feeType: json['fee_type'],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        'center_id': centerId,
        'name': name,
        'pincode': pincode,
        'session_id': sessionId,
        'date': date,
        'available_capacity': availableCapacity,
        'min_age_limit': minimumAgeLimit,
        'vaccine': vaccine,
        'fee_type': feeType,
        'slot': slot,
      };
}
