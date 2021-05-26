import 'dart:convert';

import 'package:sprintf/sprintf.dart';
import 'package:http/http.dart' as http;

import 'package:cowin_vaccine_slots/constants.dart';
import 'package:cowin_vaccine_slots/models/state.dart';
import 'package:cowin_vaccine_slots/models/district.dart';
import 'package:cowin_vaccine_slots/models/schedule_for_week.dart';

class CowinApiManager {
  static var client = http.Client();

  static States statesObj;
  static Districts districtsObj;

  static Future<States> getStates() async {
    States states;
    var res = await client.get(Uri.parse(ApiConstants.GET_STATES));

    if (res.statusCode == 200) {
      var jsonString = res.body;
      var jsonMap = jsonDecode(jsonString);
      states = States.fromJson(jsonMap);
    }
    return states;
  }

  static Future<Districts> getDistrictFromStateId(int id) async {
    Districts districts;
    var res = await client.get(Uri.parse(ApiConstants.GET_DISTRICTS + '/$id'));
    if (res.statusCode == 200) {
      var jsonString = res.body;
      var jsonMap = jsonDecode(jsonString);
      districts = Districts.fromJson(jsonMap);
    }
    return districts;
  }

  static Future<ScheduleForWeek> getCalendarByDistrict(
      int districtId, String date) async {
    ScheduleForWeek scheduleForWeek;

    var res = await client.get(
      Uri.parse(
        sprintf(ApiConstants.GET_CALENDAR_BY_DISTRICT, [
          districtId,
          date,
        ]),
      ),
    );
    if (res.statusCode == 200) {
      var jsonString = res.body;
      var jsonMap = jsonDecode(jsonString);
      scheduleForWeek = ScheduleForWeek.fromJson(jsonMap);
    }

    return scheduleForWeek;
  }
}
