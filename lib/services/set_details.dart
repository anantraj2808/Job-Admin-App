import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

setUserDetails(BuildContext context, String jwt) async {
  Admin userProvider = Provider.of<Admin>(context,listen: false);
  String url = BASE_API + SET_DETAILS;

  final http.Response response = await http.get(
    url,
    headers: <String, String>{
      'auth-token' : jwt
  }
  );

  print("Set details response code = " + response.statusCode.toString());
  var responseData = jsonDecode(response.body);
  var data = responseData['data'];

  if (response.statusCode == 200){
    userProvider.setName(data['name']);
    userProvider.setCompanyName(data['company']);
    userProvider.setEmail(data['email']);
    userProvider.setPhoneNumber(data['phone']);
    userProvider.setUid(data['_id']);
    return true;
  }

  Fluttertoast.showToast(
      msg: 'Some unknown error occured \:\(',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0
  );
  return false;

}