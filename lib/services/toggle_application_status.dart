import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> toggleApplicationStatus(String applicationId, String status) async {
  String url = BASE_API + TOGGLE_APPLICATION_STATUS;
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();

  dynamic map = {
    "application" : applicationId,
    "status" : status
  };

  print("Map = $map");

  final http.Response response = await http.post(
    url,
    body: json.encode(map),
    headers: {
      "auth-token" : jwt,
      "Content-Type" : "application/json"
    }
  );

  print("Toggle application status response code = ${response.statusCode}");

  if(response.statusCode == 200) return true;


  Fluttertoast.showToast(
      msg: 'Some unknown error occurred \:\(',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0
  );
  return false;
}