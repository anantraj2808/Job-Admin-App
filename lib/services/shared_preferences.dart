import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  final String userJWTSharedPrefs = "User_JWT";
  final String loggedInStatusSharedPrefs = "User_Logged_In_Status";

  Future setUserJWTSharedPrefs(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userJWTSharedPrefs,jwt);
  }

  Future setUserLoggedInStatusSharedPrefs(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(loggedInStatusSharedPrefs,isUserLoggedIn);
  }



  Future getUserJWTSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userJWTSharedPrefs);
  }

  Future getUserLoggedInStatusSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInStatusSharedPrefs);
  }
}