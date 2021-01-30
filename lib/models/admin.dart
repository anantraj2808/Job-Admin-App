import 'package:flutter/cupertino.dart';

class Admin with ChangeNotifier{

  String _name = "";
  String _companyName = "";
  String _phoneNumber = "";
  String _email = "";
  String _uid = "";

  setName(String name){
    _name = name;
    notifyListeners();
  }

  setCompanyName(String companyName){
    _companyName = companyName;
    notifyListeners();
  }

  setPhoneNumber(String phoneNumber){
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  setEmail(String email){
    _email = email;
    notifyListeners();
  }

  setUid(String uid){
    _uid = uid;
    notifyListeners();
  }

  String get name => _name;
  String get companyName => _companyName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get uid => _uid;

}