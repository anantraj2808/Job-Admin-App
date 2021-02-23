import 'dart:convert';

import 'package:job_admin_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/services/shared_preferences.dart';

Future<bool> toggleJobStatus(String jobId,bool status) async {
  String url = BASE_API + TOGGLE_JOB_STATUS;
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();

  Map<String,String> map = {
    "job" : jobId,
    "active" : status.toString()
  };

  final http.Response response = await http.post(
      url,
      body: json.encode(map),
      headers: <String,String>{
        "Content-type" : "application/json",
        "auth-token" : jwt
      }
  );

  print("Toggle Job status response code = " + response.statusCode.toString());

  if (response.statusCode == 200) return true;
  return false;

}