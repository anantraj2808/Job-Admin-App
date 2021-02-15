import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

editProfile(BuildContext context) async {
  Admin userProvider = Provider.of<Admin>(context,listen: false);
  String url = BASE_API + EDIT_PROFILE;
  String jwt = await SharedPrefs().getUserJWTSharedPrefs();

  dynamic map = {
    "phone": userProvider.phoneNumber,
    "name": userProvider.name,
    "email": userProvider.email,
    "company": userProvider.companyName
  };

  final http.Response response = await http.post(
    url,
    body: json.encode(map),
    headers: {
      "auth-token" : jwt,
      "Content-Type" : "application/json"
    }
  );

  print("Edit Profile response code = ${response.statusCode}");

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