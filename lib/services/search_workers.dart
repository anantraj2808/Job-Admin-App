import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/services/shared_preferences.dart';

Future<List<Applicant>> searchWorkers(String profession, String city, String state) async {
  String url = BASE_API + SEARCH_WORKERS;
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();
  if (city == "Select a city") city = "";
  if (state == "Select a state") state = "";
  if (profession == "") profession = "Select a Profession";

  List<Applicant> applicantList = [];
  Map<String,dynamic> map = {
    "profession" : profession.toLowerCase(),
    "location" : {
      "city" : city.toLowerCase(),
      "state" : state.toLowerCase()
    }
  };

  final http.Response response = await http.post(
    url,
    body: json.encode(map),
    headers: <String,String>{
      "Content-Type" : "application/json",
      "auth-token" : jwt
    }
  );

  print("Search Status code = ${response.statusCode}");
  var responseBody = jsonDecode(response.body);
  var data = responseBody['data'];

  if (response.statusCode == 200){
    for (int i=0 ; i<data.length ; i++){
      applicantList.add(Applicant().applicantFromJson(data[i]));
    }
    return applicantList;
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