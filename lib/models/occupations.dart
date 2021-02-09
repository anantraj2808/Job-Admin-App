class Occupation{
  String id;
  String occupation;

  Occupation({this.id, this.occupation});

  Occupation occupationFromJson(Map<String,dynamic> json){
    return Occupation(
      id: json['id'],
      occupation: json['occupation']
    );
  }
}