import 'package:job_admin_app/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

Text RegularTextMed(String text,double size,Color color,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily,fontWeight: FontWeight.bold),);
}

Text RegularTextReg(String text,double size,Color color,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily),);
}


//With Center Alignment
Text RegularTextMedCenter(String text,double size,Color color,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
}

Text RegularTextRegCenter(String text,double size,Color color,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily),textAlign: TextAlign.center,);
}


//With Overflow control
Text RegularTextMedOverflow(String text,double size,Color color, int line,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: line,);
}

Text RegularTextRegOverflow(String text,double size,Color color, int line,String fontFamily){
  return Text(text,style: TextStyle(fontSize: size,color: color,fontFamily: fontFamily),overflow: TextOverflow.ellipsis,maxLines: line);
}