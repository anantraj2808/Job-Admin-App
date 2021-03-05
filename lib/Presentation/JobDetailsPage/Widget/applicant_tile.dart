import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/applicant.dart';
import 'package:job_admin_app/constants/colors.dart';

applicantListTile(BuildContext context, int index, Applicant applicant){
  var ht = MediaQuery.of(context).size.height;
  var wd = MediaQuery.of(context).size.width;
  //index = 0;
  Color textColor = index%2 == 0 ? WHITE : THEME_DARK_BLUE;
  Color boxColor = index%2 == 0 ? THEME_DARK_BLUE : THEME_LIGHT_BLUE;
  return Material(
    color: boxColor,
    elevation: 10.0,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      height: 100.0,
      width: wd,
      child: ListTile(
        leading: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle,
                ),
                child: Center(child: RegularTextReg((index+1).toString(), 14.0, boxColor, BALOO),),
              )
            ],
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          //padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      child: RegularTextMed(applicant.name, 20.0, textColor, BALOO)),
                  SizedBox(width: 10.0,),
                  RegularTextReg("\( ${applicant.age} ${applicant.gender.substring(0,1)} \)", 18.0, textColor, BALOO)
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,color: textColor,size: 18.0,),
                        RegularTextReg(" ${applicant.city}, ${applicant.state}", 16.0, textColor, BALOO),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.language_outlined,color: textColor,size: 18.0,),
                        RegularTextReg(" ${applicant.language}", 16.0, textColor, BALOO),
                        SizedBox(width: 16.0,),
                        Icon(Icons.monetization_on_outlined,color: textColor,size: 18.0,),
                        RegularTextReg(" ${applicant.salaryRange}", 16.0, textColor, BALOO),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.only(top: 25.0),
          child: Icon(Icons.arrow_forward_ios,color: textColor,size: 16.0,)
        ),
      )
    ),
  );
}