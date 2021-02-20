import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/services/shared_preferences.dart';

Future<bool> changePassword(String oldPassword, String newPassword) async {
  String url = BASE_API + CHANGE_PASSWORD;
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();
  print("JWT = $jwt");

  Map<String,String> map = {
    "oldPass" : oldPassword,
    "pass1" : newPassword,
    "pass2" : newPassword
  };

  final http.Response response = await http.post(
    url,
    body: json.encode(map),
    headers: <String,String>{
      'auth-token' : jwt,
      'Content-Type' : 'application/json'
    }
  );

  print("Change Password response code = " + response.statusCode.toString());

  if(response.statusCode == 200) return true;


  Fluttertoast.showToast(
      msg: 'Some unknown error occurred\:\(, Retry',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0
  );
  return false;
}