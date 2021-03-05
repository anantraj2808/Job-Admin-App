import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/job.dart';

Widget jobListingCard(BuildContext context, Job job, int index){
  var ht = MediaQuery.of(context).size.height;
  var wd = MediaQuery.of(context).size.width;
  Color textColor = index%2 == 0 ? WHITE : THEME_DARK_BLUE;
  Color boxColor = index%2 == 0 ? THEME_DARK_BLUE : THEME_LIGHT_BLUE;
  int professionIndex = PROFESSION_LIST.indexOf(job.profession) - 1;
  bool isJobActive = job.isActive == "true" ? true : false;
  String payBasis = job.payBasis == "Per Day" ? "/day" : "/month";
  return Material(
    color: boxColor,
    elevation: 10.0,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      width: wd,
      padding: EdgeInsets.all(ht*0.013),
      child: Container(
        height: 100.0,
        width: wd,
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(PROFESSION_ICON_LIST[professionIndex],color: textColor,)
            ],
          ),
          title: Container(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularTextMed(job.profession, 20.0, textColor, BALOO),
                    RegularTextReg(job.dutyType, 16.0, textColor, BALOO)
                  ],
                ),
                SizedBox(height: ht * 0.01,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RegularTextMed("₹ " + job.salary + " ", 18.0, textColor, BALOO),
                      RegularTextReg(payBasis, 18.0, textColor, BALOO),
                      Spacer(),
                      RegularTextMed(job.openings, 16.0, textColor, BALOO),
                      RegularTextReg(" Openings", 16.0, textColor, BALOO),
                    ],
                  ),
                ),
                SizedBox(height: ht * 0.013,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(-5.0, 0, 0),
                      width: 150.0,
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: textColor,),
                          Flexible(child: RegularTextRegOverflow(" ${job.city}, ${job.state}", 16.0, textColor, 1, BALOO)),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height : 10.0,
                      width : 10.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isJobActive ? GREEN : RED
                      ),
                    ),
                    RegularTextReg(isJobActive ? "  Active" : "  Inactive", 14.0, textColor, BALOO)
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    ),
  );
}