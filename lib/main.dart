import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './locator.dart';
import 'package:cowin_vaccine_slots/styling.dart';
import 'package:cowin_vaccine_slots/ui/router.dart';
import 'package:cowin_vaccine_slots/ui/utils/size_config.dart';
import 'package:cowin_vaccine_slots/ui/views/startup_view.dart';
import 'package:cowin_vaccine_slots/services/navigation_service.dart';
import 'package:cowin_vaccine_slots/managers/notification_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final _notificationHandler = locator<NotificationHandler>();
  _notificationHandler.initLocalNotification();
  _notificationHandler.setOnNotificationReceive(
    _notificationHandler.onNotificationReceive,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                title: 'Cowin Vaccine Slots',
                debugShowCheckedModeBanner: false,
                navigatorKey: _navigationService.navigatorKey,
                onGenerateRoute: CustomRouter.generateRoute,
                theme: AppTheme.lightTheme,
                home: StartUpView(),
              );
            },
          );
        },
      ),
    );
  }
}
