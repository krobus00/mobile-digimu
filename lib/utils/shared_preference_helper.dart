import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String token = "TOKEN";
  static const String onboard = "ONBOARD";
  final SharedPreferences prefs;

  SharedPreferenceHelper({required this.prefs});

  Future<void> setUserToken({required String userToken}) async {
    await prefs.setString(token, userToken);
  }

  Future<void> removeUserToken() async {
    await prefs.remove(token);
  }

  String? getUserToken() {
    final userToken = prefs.getString(token);
    return userToken;
  }

  Future<void> setOnboardFlag({required bool flag}) async {
    await prefs.setBool(onboard, flag);
  }

  bool getOnboardFlag() {
    final flag = prefs.getBool(onboard);
    return flag ?? false;
  }
}
