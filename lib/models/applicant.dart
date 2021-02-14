import 'package:job_admin_app/models/occupations.dart';

class Applicant{
  String id;
  String phoneNumber;
  String city;
  String state;
  List<Occupation> occupations;
  String age;
  String gender;
  String name;
  String language;
  String salaryRange;
  String applicationId;

  Applicant({this.id, this.phoneNumber, this.city, this.state, this.occupations,
      this.age, this.gender, this.name, this.language, this.salaryRange,this.applicationId});

  Applicant applicantFromJson(Map<String,dynamic> json){
    return Applicant(
      id: json['id'],
      phoneNumber: json['contactNumber'],
      city: json['city'],
      state: json['state'],
      age: json['age'],
      gender: json['gender'],
      name: json['name'],
      language: json['language'],
      salaryRange: json['salaryRange'],
      applicationId: json['applicationId'],
      occupations: getOccupationsList(json['occupations'])
    );
  }

  getOccupationsList(List list){
    List<Occupation> occupationList = [];
    for (int i=0 ; i<list.length ; i++){
      occupationList.add(Occupation().occupationFromJson(list[i]));
    }
    return occupationList;
  }
}