import 'package:Symbaa/Style/AppTheme.dart';
import 'package:flutter/material.dart';

Widget commonBackGround(BuildContext context,Widget childWidget){
  return Container(
    height: MediaQuery.sizeOf(context).height,
    width: MediaQuery.sizeOf(context).width,
    decoration: BoxDecoration(
      color: AppColor.appThemeBG,
      image: const DecorationImage(
        alignment: Alignment.topCenter,
        image: AssetImage('assets/images/img_theme_bg.png'),
      ),
    ),
    child: childWidget,
  );
}