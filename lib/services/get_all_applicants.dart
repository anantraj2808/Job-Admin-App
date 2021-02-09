import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/applicant.dart';

Future<List<Applicant>> getAllApplicants(String jobId) async {

  List<Applicant> applicantList = [];

  String url = BASE_API + GET_APPLICANTS + jobId;
  final http.Response response = await http.get(url);
  print("Get all applicants response code = ${response.statusCode}");

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