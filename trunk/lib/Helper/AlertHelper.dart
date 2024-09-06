import 'package:Symbaa/Helper/SnackbarHelper/CustomSnackbar.dart';
import 'package:Symbaa/Helper/SnackbarHelper/TopSnackBar.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AlertHelper {

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        // backgroundColor: AppColor.appBlackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showAppSnackBar(BuildContext context, {String message = '', bool isError = false}) {
    if (message.isNotEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message ?? '',
          textAlign: TextAlign.start,
          backgroundColor: isError ? AppColor.appRedColor : AppColor.appPrimaryColor.withOpacity(0.9),
          textStyle: Fonts.textStyleRegular.copyWith(fontSize: 14,color: AppColor.appWhiteColor),
        ),
      );

      /* ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.zero,
          elevation: 0,
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: isError
                ? const BoxDecoration()
                : BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(-1.0, -8.0),
                      end: const Alignment(1.0, 8.0),
                      colors: [AppColor.appSecondaryColor, AppColor.appPrimaryColor],
                      // begin: Alignment.centerLeft, end: Alignment.centerRight,
                    ),
                  ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: isError ? AppColor.appRedColor : AppColor.appPrimaryColor,
        ),
      );*/

      /* Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: isError ? AppColor.appRedColor : AppColor.appSecondaryColor,
          textColor: Colors.white,
          fontSize: 16.0);*/
    }
  }
}
