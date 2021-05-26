import 'package:get_it/get_it.dart';

import './services/navigation_service.dart';
import './services/connectivity_service.dart';
import './services/local_storage_service.dart';

import './managers/notification_handler.dart';

import './viewmodels/home_viewmodel.dart';
import './viewmodels/startup_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ConnectivityService());
  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  locator.registerLazySingleton(() => NotificationHandler());

  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => HomeViewModel());
}
