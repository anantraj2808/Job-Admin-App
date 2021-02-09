import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_admin_app/WidgetsAndStyles/text_styles.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:job_admin_app/constants/strings.dart';
import 'package:job_admin_app/models/job.dart';

jobLListCard(Job job, BuildContext context, int index){
  print("Job ID = "+job.id);
  var ht = MediaQuery.of(context).size.height;
  Color textColor = index%2 == 0 ? WHITE : BLACK;
  Color shadyColor = index%2 == 0 ? SHADY_BLACK : SHADY_WHITE;
  int professionIndex = PROFESSION_LIST.indexOf(job.profession) - 1;
  bool isJobActive = job.isActive == "true" ? true : false;
  return Material(
    color: index%2 == 0 ? BLACK : WHITE,
    elevation: 10.0,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      width: 200.0,
      padding: EdgeInsets.all(ht*0.018),
      child: Container(
        height: 100.0,
        width: 200.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: shadyColor,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  width: 90.0,
                  child: RegularTextRegCenter(job.city, 18.0, textColor, BALOO),
                ),
                SizedBox(width: ht*0.013,),
                Container(
                  decoration: BoxDecoration(
                      color: shadyColor,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  width: 70.0,
                  child: RegularTextRegCenter(job.dutyType, 14.0, textColor, BALOO),
                ),
              ],
            ),
            SizedBox(height: 6.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(PROFESSION_ICON_LIST[professionIndex],color: textColor,),
                SizedBox(width: 10.0,),
                RegularTextMedCenter(job.profession, 20.0, textColor, BALOO),
              ],
            ),
            SizedBox(height: 2.0,),
            Container(
              alignment: Alignment.centerLeft,
              child: RegularTextRegCenter("₹ " + job.salary + " " + job.payBasis, 18.0, textColor, BALOO)),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
            )
          ],
        ),
      ),
    ),
  );
}