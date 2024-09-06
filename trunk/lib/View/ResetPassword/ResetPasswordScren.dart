import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/ApiState.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/commonLoader.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomAppBar.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/ResetPasswordSuccess/ResetPasswordSuccessScreen.dart';
import 'package:Symbaa/View/Signup/SignupScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/Regex.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Style/AppTheme.dart';
import 'ResetPasswordViewModel.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? email;
  String? otp;
  ResetPasswordScreen({this.email, this.otp, super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin {
  ResetPasswordViewModel resetPasswordViewModel = ResetPasswordViewModel();

  @override
  void initState() {
    super.initState();
    resetPasswordViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => resetPasswordViewModel,
      child: Consumer<ResetPasswordViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomAppBar(
                  backgroundColor: AppColor.appBlackColor,
                  onBackPressed: () {
                    NavigatorHelper.remove();
                  },
                  showWhiteBackIcon: true,
                  showBackIcon: true,
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
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    color: AppColor.appBlackColor,
                    height: MediaQuery.sizeOf(context).height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 10,
                          right: 10,
                          child: Container(
                            color: AppColor.appBlackColor,
                            width: MediaQuery.sizeOf(context).width,
                            height: 270,
                            child: AssetsHelper.getAssetImage(name: 'img_reset_pwd.png', fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 300,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: ShapeDecoration(
                              color: AppColor.appPrimaryColor,
                              shadows: [
                                BoxShadow(
                                  color: AppColor.appSecondaryColor.withOpacity(0.27),
                                  offset: const Offset(0, 8.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 20,
                                ),
                              ],
                              image: const DecorationImage(
                                image: AssetImage('assets/images/img_login_bg.png'),
                                fit: BoxFit.cover,
                              ),
                              shape: SmoothRectangleBorder(
                                  side: BorderSide(width: 1, color: AppColor.appCurveBorderColor),
                                  borderRadius: const SmoothBorderRadius.only(
                                      topLeft: SmoothRadius(
                                        cornerRadius: 25,
                                        cornerSmoothing: 0.5,
                                      ),
                                      topRight: SmoothRadius(
                                        cornerRadius: 35,
                                        cornerSmoothing: 0.5,
                                      ))),
                            ),
                            child: Hero(
                              tag: heroLoginSignup,
                              child: Material(
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 0,bottom: 55),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Form(
                                      key: resetPasswordViewModel.formKeyResetPassword,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 25, right: 25),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CommonWidget.getFieldSpacer(height: 28),
                                              Text(
                                                buildTranslate(context, 'resetPassword'),
                                                style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 8),
                                              Text(
                                                widget.email.toString(),
                                                textAlign: TextAlign.center,
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appColorYellow, fontSize: 15),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 22),
                                              CustomTextField(
                                                tecController: resetPasswordViewModel.newPasswordController,
                                                focusNode: resetPasswordViewModel.fnPassword,
                                                hintText: buildTranslate(context, 'createNewPassword'),
                                                labelText: "${buildTranslate(context, 'newPassword')}*",
                                                validator: (value) {
                                                  return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterPassword');
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              CustomTextField(
                                                tecController: resetPasswordViewModel.confirmPasswordController,
                                                focusNode: resetPasswordViewModel.fnConfirmPassword,
                                                hintText: buildTranslate(context, 'hintReEnterPassword'),
                                                labelText: "${buildTranslate(context, 'confirmPassword')}*",
                                                validator: (value) {
                                                  return ValidationHelper.checkConfirmPasswordValidation(
                                                      context, value, resetPasswordViewModel.newPasswordController.text);
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 25),
                                              ButtonView(
                                                buttonTextName: buildTranslate(context, 'reset').toUpperCase(),
                                                onPressed: () async {
                                                   if (resetPasswordViewModel.formKeyResetPassword.currentState?.validate() ?? false) {
                                                     resetPasswordViewModel.resetPassword(
                                                       widget.email.toString(),
                                                       widget.otp.toString(),
                                                     );
                                                   }
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 35),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              if (resetPasswordViewModel.userResetPassword.state == ApiState.LOADING) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
