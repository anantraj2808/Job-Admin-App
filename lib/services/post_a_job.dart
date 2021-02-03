import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/models/job.dart';
import 'dart:convert';


Future<bool> postJob(Job job, String jwt) async {
  String url = BASE_API + CREATE_JOB;

  dynamic map = Job().jobToJson(job);

  print("JWT = " + jwt);
  print("Map = " + json.encode(map));

  final http.Response response = await http.post(
    url,
    body: json.encode(map),
    headers: <String,String>{
      'Content-Type' : 'application/json',
      'auth-token' : jwt
    }
  );

  print("Post a job response code = " + response.statusCode.toString());
  var responseData = jsonDecode(response.body);

  if (response.statusCode == 200) return true;
  return false;

}