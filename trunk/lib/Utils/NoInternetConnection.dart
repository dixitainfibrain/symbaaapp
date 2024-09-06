import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColor.appPrimaryColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/anim/noInternet.json',
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
          CommonWidget.getFieldSpacer(width: 10),
          Text(
            buildTranslate(context, 'CheckYourInternet'),
            textAlign: TextAlign.center,
            style: Fonts.textStyleSemiBold.copyWith(
              fontSize: 16,
              color: AppColor.appWhiteColor,
            ),
          ),
          CommonWidget.getFieldSpacer(width: 10),
          ButtonView(
            buttonTextName: buildTranslate(context, 'Ok').toUpperCase(),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
