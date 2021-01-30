import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:job_admin_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

login(BuildContext context, String email, String password) async {
  Admin userProvider = Provider.of<Admin>(context);
  String url = BASE_API + LOGIN;

  dynamic map = <String,String>{
    'email' : email,
    'password' : password
  };

  final http.Response response = await http.post(
    url,
    headers: <String,String>{
      'Content-Type' : 'application/json'
    },
    body: json.encode(map);
  );

  print("Login response code = " + response.statusCode.toString());
  var responseBody = jsonDecode(response.body);
  var data = responseBody['data'];
  print("User Data = " + data.toString());

  if(response.statusCode == 200){
    await SharedPrefs().setUserJWTSharedPrefs(responseBody['token']);
    await SharedPrefs().setUserLoggedInStatusSharedPrefs(true);
    userProvider.setUid(data['_id']);
    userProvider.setName(data['name']);
    userProvider.setEmail(data['email']);
    userProvider.setCompanyName(data['company']);
    userProvider.setPhoneNumber(data['phone']);
    return true;
  }

  return false;

}