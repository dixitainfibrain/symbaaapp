import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomAppBar.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/Login/LoginScreen.dart';
import 'package:Symbaa/View/Signup/SignupScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/Regex.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Style/AppTheme.dart';
import 'ResetPasswordSuccessViewModel.dart';

class ResetPasswordSuccessScreen extends StatefulWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  State<ResetPasswordSuccessScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordSuccessScreen> with SingleTickerProviderStateMixin {
  ResetPasswordSuccessViewModel resetPasswordSuccessViewModel = ResetPasswordSuccessViewModel();

  @override
  void initState() {
    super.initState();
    resetPasswordSuccessViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => resetPasswordSuccessViewModel,
      child: Consumer<ResetPasswordSuccessViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: AppColor.appBlackColor,
            bottomNavigationBar: Container(
              padding:  EdgeInsets.only(left: 25, right: 25, top: 0, bottom: AppGlobal.hasNotch(context) ? 55 : 15),
              child:  ButtonView(
                buttonTextName: buildTranslate(context, 'login').toUpperCase(),
                color: AppColor.appPrimaryColor,
                textColor: AppColor.appWhiteColor,
                borderColor: AppColor.appPrimaryColor,
                onPressed: () async {
                  NavigatorHelper.removeAllAndOpen(const LoginScreen());
                },
              ),
            ),
            appBar: CustomAppBar(
              backgroundColor: AppColor.appBlackColor,
              onBackPressed: () {
                NavigatorHelper.remove();
              },
              showBackIcon: false,
              statusBarColor: AppColor.appBlackColor,
              centerTitle: true,
              childrens: [
                SvgPicture.asset(
                  AssetsHelper.getSVGIcon("ic_symbaa_logo.svg"),
                  height: 30,
                  width: 30,
                ),
              ],
            ),
            body: Container(
              color: AppColor.appBlackColor,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidget.getFieldSpacer(height:MediaQuery.sizeOf(context).width * 0.22),
                  AssetsHelper.getAssetImage(
                    name: 'img_reset_pwd_success.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: 300.0
                  ),
                  CommonWidget.getFieldSpacer(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      buildTranslate(context, 'passwordChangedSuccessfully'),
                      textAlign: TextAlign.center,
                      style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
