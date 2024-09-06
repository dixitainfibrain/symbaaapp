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
import 'package:country_picker/country_picker.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/Regex.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Style/AppTheme.dart';
import 'ForgotPasswordViewModel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  ForgotPasswordViewModel forgotPasswordViewModel = ForgotPasswordViewModel();

  @override
  void initState() {
    super.initState();
    forgotPasswordViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => forgotPasswordViewModel,
      child: Consumer<ForgotPasswordViewModel>(
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
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 300,
                            color: AppColor.appBlackColor,
                            width: MediaQuery.sizeOf(context).width,
                            padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
                            child: AssetsHelper.getAssetImage(name: 'img_forgot_pwd.png', fit: BoxFit.cover, height: 300.0),
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
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: forgotPasswordViewModel.formKeyForgotPassword,
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 0, bottom: 55),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CommonWidget.getFieldSpacer(height: 28),
                                              Center(
                                                child: Text(
                                                  buildTranslate(context, 'forgotPassword_'),
                                                  textAlign: TextAlign.center,
                                                  style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 8),
                                              Center(
                                                child: Text(
                                                  buildTranslate(context, 'noWorriesWeWillSendYouResetInstructions'),
                                                  textAlign: TextAlign.center,
                                                  style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 15),
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 22),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: CustomTextField(
                                                  tecController: forgotPasswordViewModel.emailController,
                                                  focusNode: forgotPasswordViewModel.fnEmail,
                                                  hintText: buildTranslate(context, 'hintEmail'),
                                                  labelText: "${buildTranslate(context, 'email')}*",
                                                  validator: (value) {
                                                    return ValidationHelper.checkEmailValidation(context, value);
                                                  },
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              Container(
                                                padding: const EdgeInsets.only(left: 25, right: 25),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      buildTranslate(context, 'mobileNumber'),
                                                      style: Fonts.textStyleRegular.copyWith(
                                                        fontSize: 16,
                                                        color: AppColor.appWhiteColor,
                                                      ),
                                                    ),
                                                    CommonWidget.getFieldSpacer(height: 10),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          flex: 0,
                                                          child:
                                                          InkWell(
                                                            onTap: (){
                                                              showCountryPicker(
                                                                showPhoneCode: true,
                                                                context: context,
                                                                onSelect: (value) {
                                                                  forgotPasswordViewModel.selectCountryCode("+${value.phoneCode}");
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor.appPrimaryLightColor,
                                                                  border: Border.all(
                                                                    color: AppColor.appCurveBorderColor,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  forgotPasswordViewModel.countryCode.toString(),
                                                                  style: Fonts.textStyleSemiBold.copyWith(color: AppColor.appWhiteColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        CommonWidget.getFieldSpacer(width: 10),
                                                        Flexible(
                                                          flex: 3,
                                                          child: CustomTextField(
                                                            tecController: forgotPasswordViewModel.mobileController,
                                                            focusNode: forgotPasswordViewModel.fnMobile,
                                                            hintText: buildTranslate(context, 'hintMobileNumber'),
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(10),
                                                              FilteringTextInputFormatter.allow(Regex.onlyDigits)
                                                            ],
                                                            textInputType: TextInputType.number,
                                                            validator: (value) {
                                                              return ValidationHelper.checkMobileNoValidation(context, value);
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 25),
                                              Center(
                                                child: ButtonView(
                                                  buttonTextName: buildTranslate(context, 'send').toUpperCase(),
                                                  onPressed: () async {

                                                    // Navigator.of(context).push(MaterialPageRoute(
                                                    //     builder: (context) => OTPScreen(
                                                    //           isEmailAuth: true,
                                                    //         )));

                                                    // TODO API Call
                                                     if (forgotPasswordViewModel.formKeyForgotPassword.currentState?.validate() ?? false) {
                                                       forgotPasswordViewModel.sendEmailAndMobile();
                                                     }
                                                  },
                                                ),
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

              if (forgotPasswordViewModel.userForgotVerifyData.state == ApiState.LOADING) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
