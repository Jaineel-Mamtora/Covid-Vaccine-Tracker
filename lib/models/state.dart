import 'dart:convert';

States statesFromJson(String str) => States.fromJson(json.decode(str));

String statesToJson(States data) => json.encode(data.toJson());

class States {
  States({
    this.states,
    this.ttl,
  });

  List<State> states;
  int ttl;

  factory States.fromJson(Map<String, dynamic> json) => States(
        states: List<State>.from(json['states'].map((x) => State.fromJson(x))),
        ttl: json['ttl'],
      );

  Map<String, dynamic> toJson() => {
        'states': List<dynamic>.from(states.map((x) => x.toJson())),
        'ttl': ttl,
      };
}

class State {
  State({
    this.stateId,
    this.stateName,
  });

  int stateId;
  String stateName;

  factory State.fromJson(Map<String, dynamic> json) => State(
        stateId: json['state_id'],
        stateName: json['state_name'],
      );

  Map<String, dynamic> toJson() => {
        'state_id': stateId,
        'state_name': stateName,
      };
}
