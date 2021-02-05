class Job{
  String companyName;
  String email;
  String phoneNumber;
  String state;
  String city;
  String profession;
  String jobDescription;
  String payBasis;
  String salary;
  String dutyType;
  String openings;
  String minimumQualifications;
  String language;
  String experience;
  String workTimings;
  String address;

  Job({
      this.companyName,
      this.email,
      this.phoneNumber,
      this.state,
      this.city,
      this.profession,
      this.jobDescription,
      this.payBasis,
      this.salary,
      this.dutyType,
      this.openings,
      this.minimumQualifications,
      this.language,
      this.experience,
      this.workTimings,
      this.address
  });

  Map<String, dynamic>  jobToJson(Job jobInstance) =>
      <String, String>{
        "companyName" : jobInstance.companyName,
        "city" : jobInstance.city,
        "state" : jobInstance.state,
        "salary" : jobInstance.salary,
        "payBasis" : jobInstance.payBasis,
        "professionType" : jobInstance.profession,
        "type" : jobInstance.dutyType,
        "openings" : jobInstance.openings,
        "minQualification" : jobInstance.minimumQualifications,
        "language" : jobInstance.language,
        "jobDescription" : jobInstance.jobDescription,
        "minExperience" : jobInstance.experience,
        "timing" : jobInstance.workTimings,
        "address" : jobInstance.address,
      };

  Job jobFromJson(Map<String,dynamic> json){
    return Job(
      companyName: json['companyName'],
      city: json['city'],
      state: json['state'],
      salary: json['salary'],
      payBasis: json['payBasis'],
      profession: json['professionType'],
      dutyType: json['type'],
      openings: json['openings'],
      minimumQualifications: json['minQualification'],
      language: json['language'],
      jobDescription: json['jobDescription'],
      experience: json['minExperience'],
      workTimings: json['timing'],
      address: json['address']
    );
  }
}