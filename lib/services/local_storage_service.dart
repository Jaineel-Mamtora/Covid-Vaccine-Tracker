import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static const String isNotificationClickedKey = 'is_notification_clicked_key';

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  bool get isNotificationClicked =>
      _getFromDisk(isNotificationClickedKey) ?? false;

  set isNotificationClicked(bool isNotificationClicked) {
    _saveToDisk(isNotificationClickedKey, isNotificationClicked);
  }

  Future<void> clearPreferences() async {
    await _preferences.clear();
  }
}
