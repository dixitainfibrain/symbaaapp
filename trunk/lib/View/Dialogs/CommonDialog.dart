import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Localization/languageSettings.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';

class CommonDialog extends StatelessWidget {
  final String title, description;
  final Function() onYesPressed, onNoPressed;

  CommonDialog({
    required this.title,
    required this.description,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Fonts.textStyleBold.copyWith(color: AppColor.appPrimaryColor, fontSize: 22),
            ),
          ),
          CommonWidget.getFieldSpacer(height: 10),
          Center(
            child: Text(
              description,
              style: Fonts.textStyleRegular.copyWith(color: AppColor.appBlackColor, fontSize: 17),
            ),
          ),
          CommonWidget.getFieldSpacer(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ButtonView(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  borderWidth: 1.5,
                  buttonTextName: buildTranslate(context, 'no').toUpperCase(),
                  onPressed: onNoPressed
                ),
              ),
              CommonWidget.getFieldSpacer(width: 30),
              Expanded(
                child: ButtonView(
                  color: AppColor.appPrimaryColor,
                  textColor: AppColor.appWhiteColor,
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  buttonTextName: buildTranslate(context, 'yes').toUpperCase(),
                    onPressed: onYesPressed
                ),
              ),

            ],
          ),
          CommonWidget.getFieldSpacer(width: 30),
        ],
      ),
    );
  }
}
