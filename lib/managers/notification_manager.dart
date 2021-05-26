import 'package:fluttertoast/fluttertoast.dart';

import 'package:cowin_vaccine_slots/locator.dart';
import 'package:cowin_vaccine_slots/constants.dart';
import 'package:cowin_vaccine_slots/ui/views/home_view.dart';
import 'package:cowin_vaccine_slots/enums/notification_type.dart';
import 'package:cowin_vaccine_slots/services/navigation_service.dart';
import 'package:cowin_vaccine_slots/services/local_storage_service.dart';

class NotificationManager {
  final Map<String, dynamic> message;
  final _navigationService = locator<NavigationService>();
  final _localStorageService = locator<LocalStorageService>();

  NotificationManager({this.message});

  Future onNotificationClick() async {
    _localStorageService.isNotificationClicked = true;
    NotificationType type = notificationTypes
        .map[message[NotificationConstants.NOTIFICATION_TYPE].toString()];
    switch (type) {
      case NotificationType.REMINDER:
        await navigateSlotDetails();
        break;
      default:
        Fluttertoast.showToast(
          msg: NotificationConstants.NOTIFICATION_CLICK_ERROR,
        );
        break;
    }
  }

  Future<void> navigateSlotDetails() async {
    await _navigationService.pushReplacementNamed(
      HomeView.routeName,
    );
  }
}
