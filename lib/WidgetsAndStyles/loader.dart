import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:job_admin_app/constants/colors.dart';
import 'package:loading_animations/loading_animations.dart';

Widget loader(BuildContext context){
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  Widget loadingCircle = Container(
    color: WHITE,
    height: height,
    width: width,
    child: Center(
        child: LoadingFlipping.circle(
          borderColor: BLACK,
          borderSize: 3.0,
          size: 50.0,
          backgroundColor: WHITE,
          duration: Duration(milliseconds: 500),
        )
    ),
  );
  return loadingCircle;
}