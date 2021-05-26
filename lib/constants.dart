const String APP_NAME = 'Cowin Vaccine Slots';
const String FONT_NAME = 'OpenSans';
const String PACKAGE_ID = 'com.example.cowin_vaccine_slots';

class Constants {}

class ApiConstants {
  static const GET_STATES =
      """https://cdn-api.co-vin.in/api/v2/admin/location/states""";

  static const GET_DISTRICTS =
      """https://cdn-api.co-vin.in/api/v2/admin/location/districts""";

  static const GET_CALENDAR_BY_DISTRICT =
      """https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=%s&date=%s""";
}

class NotificationConstants {
  static const String DEFAULT_LOCATION = 'America/Detroit';
  static const String NOTIFICATION_CLICK_ERROR = 'Notification Click Error';
  static const String NOTIFICATION_TYPE = 'type';
  static const String PUSH_NOTIFICATION_TITLE = 'Reminder: Priority %s';
  static const String PUSH_NOTIFICATION_BODY_WITH_ONLY_FROM_TIME =
      'Todo: %s at %s';
  static const String PUSH_NOTIFICATION_BODY_WITH_BOTH_FROM_TIME_AND_TO_TIME =
      'Todo: %s from %s to %s';
}
