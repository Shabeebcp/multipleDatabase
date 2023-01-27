import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static bool isOpen = false;
  static int openedDatabse = 1;
  static String openedDbName = 'MasterDB.db';

  static writeLocalCache() async {
    var cache = await SharedPreferences.getInstance();

    cache.setBool('isOpen', isOpen);
    cache.setInt('openedDatabse', openedDatabse);
    cache.setString('openedDbName', openedDbName);
  }

  static readLocalCache() async {
    var cache = await SharedPreferences.getInstance();
    if (cache.getBool('isOpen') != null) {
      cache.getBool('isOpen');
    }
    if (cache.getInt('openedDatabse') != null) {
      cache.getInt('openedDatabse');
    }
    if (cache.getString('openedDbName') != null) {
      cache.getString('openedDbName');
    }
  }
}
