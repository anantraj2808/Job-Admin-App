import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/services/toggle_application_status.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantDetailsPage extends StatefulWidget {
  final Applicant applicant;
  final bool isApplicant;
  ApplicantDetailsPage({this.applicant,this.isApplicant});
  @override
  _ApplicantDetailsPageState createState() => _ApplicantDetailsPageState();
}

class _ApplicantDetailsPageState extends State<ApplicantDetailsPage> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print("Application ID = ${widget.applicant.applicationId}");
  }

  professionWidgetList(){
    List<Widget> widgetList = [];
    for (int i=0 ; i<widget.applicant.occupations.length ; i++){
      widgetList.add(
        Chip(
          backgroundColor: BLACK,
          label: RegularTextRegCenter(widget.applicant.occupations[i].occupation, 16.0, WHITE, BALOO),
        )
      );
    }
    return widgetList;
  }

  _callNumber() async{
    String telScheme = 'tel:+91-${widget.applicant.phoneNumber}';
    if (await canLaunch(telScheme)) {
      await launch(telScheme);
    } else {
      throw 'Could not launch $telScheme';
    }
  }

  toggleApplicationStatusRequest(String status) async {
    setState(() {
      isLoading = true;
    });
    print("Application ID = ${widget.applicant.applicationId}");
    print("Status = $status");
    await toggleApplicationStatus(widget.applicant.applicationId, status).then((val){
      if(val){
        Fluttertoast.showToast(
            msg: 'Done',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: BLACK,
            textColor: WHITE,
            fontSize: 16.0
        );
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: WHITE,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: BLACK,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          if (isLoading) loader(context),
          Opacity(
            opacity: isLoading ? 0.3 : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: ht*(1-0.209),
                  width: wd,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RegularTextMed(widget.applicant.name, 28.0, BLACK, BALOO),
                            SizedBox(width: 10.0,),
                            RegularTextReg("\( ${widget.applicant.age} ${widget.applicant.gender.substring(0,1)} \)", 22.0, BLACK, BALOO)
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Wrap(
                          runSpacing: 2.0,
                          spacing: 5.0,
                          children: professionWidgetList(),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          margin: EdgeInsets.only(left: 30.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        color: BLACK_26,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.phone_in_talk,color: BLACK,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg("+91 - "+widget.applicant.phoneNumber, 24.0, BLACK, BALOO)
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        color: BLACK_26,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.location_on_outlined,color: BLACK,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg(widget.applicant.city + "\, " + widget.applicant.state, 20.0, BLACK, BALOO)
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        color: BLACK_26,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.language_outlined,color: BLACK,size: 18.0,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg(widget.applicant.language, 20.0, BLACK, BALOO)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RegularTextReg("Preferred Salary   :  INR   ", 20.0, BLACK, BALOO),
                            RegularTextMed(widget.applicant.salaryRange, 22.0, BLACK, BALOO)
                          ],
                        ),
                        SizedBox(height: 30.0,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("Are you sure want to ACCEPT this application ?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        setState(() {
                                          toggleApplicationStatusRequest('Accepted');
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: BLACK
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.check,color: GREEN,),
                                title: RegularTextReg("Accept", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("Are you sure want to put this application IN-REVIEW ?"),
                                  actions: <Widget>[
                                FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                Navigator.of(context).pop();
                                },
                                ),
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        setState(() {
                                          toggleApplicationStatusRequest('In-Review');
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: BLACK
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.watch_later_outlined,color: YELLOW,),
                                title: RegularTextReg("In-Review", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("Are you sure want to REJECT this application ?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        setState(() {
                                          toggleApplicationStatusRequest('Rejected');
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: BLACK
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.close_outlined,color: RED,),
                                title: RegularTextReg("Reject", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: BLACK,width: 0.5))
                  ),
                  height: ht*0.1,
                  width: wd,
                  child: Center(
                    child: FlatButton(
                      height: 40.0,
                      minWidth: 120.0,
                      onPressed: (){
                        _callNumber();
                      },
                      color: BLACK,
                      child: RegularTextReg("Contact Now", 18.0, WHITE, BALOO),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
