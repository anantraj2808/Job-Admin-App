import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/home.dart';
import 'package:job_admin_app/Presentation/HomePage/home_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/admin.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/post_a_job.dart';
import 'package:job_admin_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class PostJobForm extends StatefulWidget {
  @override
  _PostJobFormState createState() => _PostJobFormState();
}

class _PostJobFormState extends State<PostJobForm> {

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _companyName = "";
  String _email = "";
  String _phone = "";

  TextEditingController emailTEC = TextEditingController();
  TextEditingController companyTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController salaryTEC = TextEditingController();
  TextEditingController openingsTEC = TextEditingController();
  TextEditingController qualificationsTEC = TextEditingController();
  TextEditingController experienceTEC = TextEditingController();
  TextEditingController timingTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController jobDescriptionTEC = TextEditingController();

  String _selectedState = statesList[0];
  List<String> citiesList = [];

  bool isLoading = false;

  String _selectedCity = "Select a city";
  String _selectedProfession = "Select a Profession";
  String _payBasis = "Choose a pay-basis";
  String _dutyType = "Choose a duty type";
  String _language = "Language to be known";

  @override
  void initState() {
    super.initState();
  }

  bool validation(){
    int invalidateCounter = 0;
    if (_selectedState == "Select a state"){
      invalidateCounter = toast("Please select a state",invalidateCounter);
      return false;
    }
    if (_selectedCity == "Select a city"){
      invalidateCounter = toast("Please select a city",invalidateCounter);
      return false;
    }
    if (_selectedProfession == "Select a Profession"){
      invalidateCounter = toast("Please select a profession",invalidateCounter);
      return false;
    }
    if (_payBasis == "Choose a pay-basis"){
      invalidateCounter = toast("Please select a pay-basis",invalidateCounter);
      return false;
    }
    if (_dutyType == "Choose a duty type"){
      invalidateCounter = toast("Please select a duty type",invalidateCounter);
      return false;
    }
    if (_language == "Language to be known"){
      invalidateCounter = toast("Please select a language",invalidateCounter);
      return false;
    }
    if (qualificationsTEC.text.trim() == "") qualificationsTEC.text = "No particular qualifications required";
    if (experienceTEC.text.trim() == "") experienceTEC.text = "No particular experience required";
    return true;
  }

  toast(String msg, int counter){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: BLACK,
        textColor: WHITE,
        fontSize: 16.0
    );
    counter += 1;
    return counter;
  }

  postJobRequest() async {
    setState(() {
      isLoading = true;
    });
    String jwt = await SharedPrefs().getUserJWTSharedPrefs();
    Job job = Job(
      city: _selectedCity,
      state: _selectedState,
      companyName: _companyName,
      phoneNumber: _phone,
      profession: _selectedProfession,
      jobDescription: jobDescriptionTEC.text,
      payBasis: _payBasis,
      salary: salaryTEC.text.toString(),
      dutyType: _dutyType,
      openings: openingsTEC.text.toString(),
      minimumQualifications: qualificationsTEC.text.toString(),
      language: _language,
      experience: experienceTEC.text.toString(),
      workTimings: timingTEC.text.toString(),
      address: addressTEC.text
    );
    await postJob(job, jwt).then((val){
      if (val){
        toast("Job posted successfully", 0);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => Home()
        ),
                (route) => false);
      }
      else toast("Some unknown error occurred", 0);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    Admin userProvider = Provider.of<Admin>(context);
    _name = userProvider.name;
    _email = userProvider.email;
    _phone = userProvider.phoneNumber;
    _companyName = userProvider.companyName;
    emailTEC.text = _email;
    companyTEC.text = _companyName;
    phoneTEC.text = _phone;
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: WHITE,
        title: RegularTextRegCenter("Post a Job", 24.0, BLACK, BALOO),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.keyboard_arrow_left,color: BLACK,size: 28.0,),
        ),
      ),
      body: Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                    child: Column(
                      children: [
                        //Company
                        Container(
                          height: 60.0,
                          child: TextFormField(
                            controller: companyTEC,
                            enabled: false,
                            style: TextStyle(color: DARK_GREY),
                            cursorColor: BLACK,
                            cursorHeight: 20.0,
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Organisation",
                              labelStyle: TextStyle(color: DARK_GREY),
                              prefixIcon: Icon(
                                Icons.people,
                                color: GREY,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: BLACK, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //email
                        Container(
                          height: 60.0,
                          child: TextFormField(
                            controller: emailTEC,
                            enabled: false,
                            style: TextStyle(color: DARK_GREY),
                            cursorColor: BLACK,
                            cursorHeight: 20.0,
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: DARK_GREY),
                              prefixIcon: Icon(
                                Icons.email,
                                color: GREY,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: BLACK, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //phone
                        Container(
                          height: 60.0,
                          child: TextFormField(
                            controller: phoneTEC,
                            enabled: false,
                            style: TextStyle(color: DARK_GREY),
                            cursorColor: BLACK,
                            cursorHeight: 20.0,
                            autofocus: false,
                            decoration: InputDecoration(
                              labelText: "Phone No.",
                              labelStyle: TextStyle(color: DARK_GREY),
                              prefixIcon: Icon(
                                Icons.phone_in_talk,
                                color: GREY,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: GREY, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: BLACK, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //state
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_searching,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedState = newValue;
                                        _selectedCity = "Select a city";
                                        if(_selectedState == statesList[1]) citiesList = gujaratCities;
                                        if(_selectedState == statesList[2]) citiesList = maharashtraCities;
                                        if(_selectedState == statesList[3]) citiesList = mpCities;
                                        if(_selectedState == statesList[4]) citiesList = punjabCities;
                                        if(_selectedState == statesList[5]) citiesList = rajasthanCities;
                                        if(_selectedState == statesList[6]) citiesList = upCities;
                                        _selectedCity = citiesList[0];
                                      });
                                    },
                                    items: statesList.map((location) {
                                      return DropdownMenuItem(
                                        child: Text(location,style: TextStyle(color: location == "Select a state" ? DARK_GREY : BLACK),),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //city
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Select a city'),
                                    value: _selectedCity,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCity = newValue;
                                      });
                                    },
                                    items: citiesList.map((city) {
                                      return DropdownMenuItem(
                                        child: new Text(city,style: TextStyle(color: city == "Select a city" ? DARK_GREY : BLACK),),
                                        value: city,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //profession
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.work_outline,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Select a profession'),
                                    value: _selectedProfession,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedProfession = newValue;
                                      });
                                    },
                                    items: PROFESSION_LIST.map((profession) {
                                      return DropdownMenuItem(
                                        child: new Text(profession,style: TextStyle(color: profession == "Select a Pofession" ? DARK_GREY : BLACK),),
                                        value: profession,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //description
                        TextFormField(
                          minLines: 3,
                          maxLines: 5,
                          validator: (val){
                            if (val.toString().trim().length <= 5){
                              return 'Enter valid job description';
                            }
                            return null;
                          },
                          controller: jobDescriptionTEC,
                          style: TextStyle(color: BLACK),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Job Description",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.details_outlined,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //pay basis
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.payment,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Choose a pay-basis'),
                                    value: _payBasis,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _payBasis = newValue;
                                      });
                                    },
                                    items: PAY_BASIS_LIST.map((payBasis) {
                                      return DropdownMenuItem(
                                        child: new Text(payBasis,style: TextStyle(color: payBasis == "Choose a pay-basis" ? DARK_GREY : BLACK),),
                                        value: payBasis,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //salary
                        TextFormField(
                          validator: (val){
                            if (val.toString().trim().length <= 2){
                              return 'Enter a valid salary';
                            }
                            return null;
                          },
                          controller: salaryTEC,
                          style: TextStyle(color: BLACK),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Salary",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //duty type
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.timer,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Choose a duty type'),
                                    value: _dutyType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _dutyType = newValue;
                                      });
                                    },
                                    items: DUTY_TYPE_LIST.map((dutyType) {
                                      return DropdownMenuItem(
                                        child: new Text(dutyType,style: TextStyle(color: dutyType == "Choose a duty type" ? DARK_GREY : BLACK),),
                                        value: dutyType,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //openings
                        TextFormField(
                          validator: (val){
                            if (val.toString().trim().length == 0){
                              return 'Enter valid number of openings';
                            }
                            return null;
                          },
                          controller: openingsTEC,
                          style: hintTextStyle(),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "No. of openings",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.format_list_numbered,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //minimum qualification
                        Container(
                          height: 60.0,
                          child: TextFormField(
                            controller: qualificationsTEC,
                            style: TextStyle(color: BLACK),
                            cursorColor: BLACK,
                            cursorHeight: 20.0,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: "Min. Qualification required (if any)",
                              labelStyle: hintTextStyle(),
                              prefixIcon: Icon(
                                Icons.book_online_outlined,
                                color: BLACK,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: BLACK, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: BLACK, width: 1.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //language
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: BLACK)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.language_outlined,color: BLACK,size: 25.0,),
                                SizedBox(width: 12.5,),
                                Expanded(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Language to be known'),
                                    value: _language,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _language = newValue;
                                      });
                                    },
                                    items: LANGUAGE_LIST.map((language) {
                                      return DropdownMenuItem(
                                        child: new Text(language),
                                        value: language,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: ht*0.015),
                        //minimum experience
                        TextFormField(
                          controller: experienceTEC,
                          style: TextStyle(color: BLACK),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: "Min. experience required (if any)",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.network_check_outlined,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //timings
                        TextFormField(
                          validator: (val){
                            if (val.toString().trim().length == 0){
                              return 'Enter valid work timings';
                            }
                            return null;
                          },
                          controller: timingTEC,
                          style: TextStyle(color: BLACK),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Work timings",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.access_time_outlined,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.015),
                        //address
                        TextFormField(
                          validator: (val){
                            if (val.toString().trim().length <= 5){
                              return 'Enter valid work address';
                            }
                            return null;
                          },
                          controller: addressTEC,
                          style: TextStyle(color: BLACK),
                          cursorColor: BLACK,
                          cursorHeight: 20.0,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Complete work address",
                            labelStyle: hintTextStyle(),
                            prefixIcon: Icon(
                              Icons.my_location_outlined,
                              color: BLACK,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: BLACK, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: BLACK, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: ht*0.03),


                        InkWell(
                          onTap: (){
                            if (_formKey.currentState.validate()){
                              if (validation()){
                                postJobRequest();
                              }
                            }
                          },
                          child: Container(
                            height:  ht*0.065,
                            width: ht*0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: BLACK
                            ),
                            child: Center(child: RegularTextMedCenter("Confirm", 22.0, WHITE, BALOO)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle hintTextStyle(){
    return TextStyle(color: DARK_GREY);
  }
}