import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

Widget commonScaffoldWidget(BuildContext context,Widget childWidget, {Widget? body}) {
  return Scaffold(
    extendBody: true,
    extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // here the desired height
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              NavigatorHelper.remove();
            },
            child: childWidget,
          ),
        ),
      ),
    body: body,
  );
}

ShapeDecoration commonScreenCardWidget(){
  return ShapeDecoration(
    color: AppColor.appBlackColor,
    shape: SmoothRectangleBorder(
      side: BorderSide(width: 1, color: AppColor.appBlackColor),
      borderRadius: const SmoothBorderRadius.only(
        topLeft: SmoothRadius(
          cornerRadius: 25,
          cornerSmoothing: 0.5,
        ),
        topRight: SmoothRadius(
          cornerRadius: 25,
          cornerSmoothing: 0.5,
        ),
      ),
    ),
  );
}