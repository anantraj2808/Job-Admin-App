import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_admin_app/Presentation/JobDetailsPage/job_details_page.dart';
import 'package:job_admin_app/WidgetsAndStyles/loader.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/models/job.dart';
import 'package:job_admin_app/services/toggle_application_status.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicantDetailsPage extends StatefulWidget {
  final Applicant applicant;
  final bool isApplicant;
  final Job job;
  ApplicantDetailsPage({this.applicant,this.isApplicant,this.job});
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
          backgroundColor: THEME_BLACK_BLUE,
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
            backgroundColor: THEME_BLACK_BLUE,
            textColor: WHITE,
            fontSize: 16.0
        );
        if(widget.isApplicant) {
          Navigator.pop(context);
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  getApplicationStatus(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height : 10.0,
          width : 10.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: text == "Accepted" ? GREEN : YELLOW
          ),
        ),
        RegularTextMed("    $text", 24.0, THEME_BLACK_BLUE, BALOO)
      ],
    );
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
          icon: Icon(Icons.arrow_back_ios,color: THEME_BLACK_BLUE,),
          onPressed: (){
            if(widget.isApplicant){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => JobDetailsPage(job: widget.job,)
              ));
            }
            else {
              Navigator.pop(context);
            }
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
                            RegularTextMed(widget.applicant.name, 28.0, THEME_BLACK_BLUE, BALOO),
                            SizedBox(width: 10.0,),
                            RegularTextReg("\( ${widget.applicant.age} ${widget.applicant.gender.substring(0,1)} \)", 22.0, THEME_BLACK_BLUE, BALOO)
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        widget.isApplicant && widget.applicant.appointmentStatus != "applied" ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height : 10.0,
                              width : 10.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.applicant.appointmentStatus == "Accepted" ? GREEN : YELLOW
                              ),
                            ),
                            RegularTextMed("    ${widget.applicant.appointmentStatus}", 20.0, THEME_BLACK_BLUE, BALOO)
                          ],
                        ) : Container(),
                        widget.isApplicant && widget.applicant.appointmentStatus != "applied" ? SizedBox(height: 20.0,) : Container(),
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
                                        color: THEME_MID_LIGHT_BLUE,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.phone_in_talk,color: THEME_BLACK_BLUE,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg("+91 - "+widget.applicant.phoneNumber, 24.0, THEME_BLACK_BLUE, BALOO)
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
                                        color: THEME_MID_LIGHT_BLUE,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.location_on_outlined,color: THEME_BLACK_BLUE,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg(widget.applicant.city + "\, " + widget.applicant.state, 20.0, THEME_BLACK_BLUE, BALOO)
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
                                        color: THEME_MID_LIGHT_BLUE,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.language_outlined,color: THEME_BLACK_BLUE,size: 18.0,),
                                    ),
                                  ),
                                  SizedBox(width: 15.0,),
                                  RegularTextReg(widget.applicant.language, 20.0, THEME_BLACK_BLUE, BALOO)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RegularTextReg("Preferred Salary   :  INR   ", 20.0, THEME_BLACK_BLUE, BALOO),
                            RegularTextMed(widget.applicant.salaryRange, 22.0, THEME_BLACK_BLUE, BALOO)
                          ],
                        ),
                        SizedBox(height: 30.0,),
                        widget.isApplicant && (widget.applicant.appointmentStatus == "applied" || widget.applicant.appointmentStatus == "In-Review") ? GestureDetector(
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => JobDetailsPage(job: widget.job,)
                                        ));
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
                                color: THEME_BLACK_BLUE
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.check,color: GREEN,),
                                title: RegularTextReg("Accept", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ) : Container(),
                        widget.isApplicant && (widget.applicant.appointmentStatus == "applied" || widget.applicant.appointmentStatus == "In-Review") ? SizedBox(height: 15.0,) : Container(),
                        widget.isApplicant && widget.applicant.appointmentStatus == "applied" ? GestureDetector(
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) => JobDetailsPage(job: widget.job,)
                                        ));
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
                                color: THEME_BLACK_BLUE
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.watch_later_outlined,color: YELLOW,),
                                title: RegularTextReg("In-Review", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ) : Container(),
                        widget.isApplicant && widget.applicant.appointmentStatus == "applied" ? SizedBox(height: 15.0,) : Container(),
                        widget.isApplicant && (widget.applicant.appointmentStatus == "applied" || widget.applicant.appointmentStatus == "In-Review") ? GestureDetector(
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context) => JobDetailsPage(job: widget.job,)
                                        ));
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
                                color: THEME_BLACK_BLUE
                            ),
                            child: Container(
                              transform: Matrix4.translationValues(0, -8, 0),
                              child: ListTile(
                                leading: Icon(Icons.close_outlined,color: RED,),
                                title: RegularTextReg("Reject", 18.0, WHITE, BALOO),
                              ),
                            ),
                          ),
                        ) : Container(),
//                        SizedBox(height: 50.0),
//                        widget.isApplicant && widget.applicant.appointmentStatus != "applied" ? Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Container(
//                              height : 20.0,
//                              width : 20.0,
//                              decoration: BoxDecoration(
//                                  shape: BoxShape.circle,
//                                  color: widget.applicant.appointmentStatus == "Accepted" ? GREEN : YELLOW
//                              ),
//                            ),
//                            RegularTextMed("    ${widget.applicant.appointmentStatus}", 24.0, THEME_BLACK_BLUE, BALOO)
//                          ],
//                        ) : Container()
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: THEME_BLACK_BLUE,width: 0.5))
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
                      color: THEME_BLACK_BLUE,
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
