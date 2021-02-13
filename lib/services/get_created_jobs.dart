import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_admin_app/services/shared_preferences.dart';

Future<List<Job>> getCreatedJobs(BuildContext context) async {
  Admin userProvider = Provider.of<Admin>(context,listen: false);
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();

  String url = BASE_API + GET_CREATED_JOBS + userProvider.uid;
  print("URL = $url");
  List<Job> temp = [];

  http.Response response = await http.get(
    url,
    headers: <String,String>{
      "auth-token" : jwt
    }
  );

  print("Get created Jobs response code = " + response.statusCode.toString());
  var responseBody = jsonDecode(response.body);
  var data = responseBody['data'];

  if (response.statusCode == 200){
    for (int i=0 ; i<data.length ; i++){
      temp.add(Job().jobFromJson(data[i]));
      print("Job $i = ${temp[i].profession.toString()}");
    }
    return temp;
  }
  else{
    Fluttertoast.showToast(
        msg: 'Some unknown error occurred \:\(',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: BLACK,
        textColor: WHITE,
        fontSize: 16.0
    );
    return [];
  }
}