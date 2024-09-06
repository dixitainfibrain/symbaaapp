import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/Regex.dart';
import 'package:Symbaa/Helper/ValidationHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/ApiState.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/commonLoader.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomAppBar.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/Login/LoginScreen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Style/AppTheme.dart';
import '../../Utils/Constants.dart';
import 'SignupViewModel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  SignupViewModel signupViewModel = SignupViewModel();

  @override
  void initState() {
    super.initState();
    signupViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => signupViewModel,
      child: Consumer<SignupViewModel>(
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
                body: Container(
                  color: AppColor.appBlackColor,
                  height: MediaQuery.sizeOf(context).height,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.appPrimaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.appSecondaryColor.withOpacity(0.27),
                            offset: const Offset(0, 5.0),
                            blurRadius: 20.0,
                            spreadRadius: 2,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/img_signup_bg.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border(
                          top: BorderSide(
                            color: AppColor.appCurveBorderColor,
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: AppColor.appCurveBorderColor,
                            width: 1.0,
                          ),
                          right: BorderSide(
                            color: AppColor.appCurveBorderColor,
                            width: 1.0,
                          ),
                        )),
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
                          child: Column(
                            children: [
                              CommonWidget.getFieldSpacer(height: 25),
                              Text(
                                buildTranslate(context, 'signup_'),
                                style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                              ),
                              CommonWidget.getFieldSpacer(height: 8),
                              Text(
                                buildTranslate(context, 'enterYourDetailsToGetStarted'),
                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 16),
                              ),
                              CommonWidget.getFieldSpacer(height: 20),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 25, right: 25),
                                    child: Form(
                                      key: signupViewModel.formKeySignup,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            tecController: signupViewModel.firstNameController,
                                            focusNode: signupViewModel.fnFirstName,
                                            hintText: buildTranslate(context, 'hintFirstName'),
                                            labelText: "${buildTranslate(context, 'firstName')}*",
                                            validator: (value) {
                                              return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterFirstName');
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 18),
                                          CustomTextField(
                                            tecController: signupViewModel.lastNameController,
                                            focusNode: signupViewModel.fnLastName,
                                            hintText: buildTranslate(context, 'hintLastName'),
                                            labelText: "${buildTranslate(context, 'lastName')}*",
                                            validator: (value) {
                                              return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterLastName');
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 18),
                                          CustomTextField(
                                            tecController: signupViewModel.emailController,
                                            focusNode: signupViewModel.fnEmail,
                                            hintText: buildTranslate(context, 'hintEmail'),
                                            labelText: "${buildTranslate(context, 'email')}*",
                                            validator: (value) {
                                              return ValidationHelper.checkEmailValidation(context, value);
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 18),
                                          Text(
                                            "${buildTranslate(context, 'mobile')}*",
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
                                                        signupViewModel.selectCountryCode("+${value.phoneCode}");
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
                                                          signupViewModel.countryCode.toString(),
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
                                                  tecController: signupViewModel.mobileController,
                                                  focusNode: signupViewModel.fnMobile,
                                                  hintText: buildTranslate(context, 'hintMobileNumber'),
                                                  // labelText: "${buildTranslate(context, 'mobile')}*",
                                                  inputFormatters: [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.allow(Regex.onlyDigits)],
                                                  textInputType: TextInputType.number,
                                                  validator: (value) {
                                                    return ValidationHelper.checkMobileNoValidation(context, value);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          CommonWidget.getFieldSpacer(height: 18),
                                          CustomTextField(
                                            tecController: signupViewModel.passwordController,
                                            focusNode: signupViewModel.fnPassword,
                                            hintText: buildTranslate(context, 'hintPassword'),
                                            labelText: "${buildTranslate(context, 'labelPassword')}*",
                                            validator: (value) {
                                              return ValidationHelper.checkPasswordValidation(context, value, 'pleaseEnterPassword');
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 18),
                                          CustomTextField(
                                            tecController: signupViewModel.confirmPasswordController,
                                            focusNode: signupViewModel.fnConfirmPassword,
                                            hintText: buildTranslate(context, 'hintReEnterPassword'),
                                            labelText: "${buildTranslate(context, 'confirmPassword')}*",
                                            validator: (value) {
                                              return ValidationHelper.checkConfirmPasswordValidation(context, value, signupViewModel.passwordController.text);
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 18),
                                          CustomTextField(
                                            tecController: signupViewModel.referralCodeController,
                                            focusNode: signupViewModel.fnReferralCode,
                                            hintText: buildTranslate(context, 'hintReferralCode'),
                                            labelText: buildTranslate(context, 'referralCode'),
                                          ),
                                          CommonWidget.getFieldSpacer(height: 50),
                                          ButtonView(
                                            buttonTextName: buildTranslate(context, 'signup_').toUpperCase(),
                                            onPressed: () async {
                                              if (signupViewModel.formKeySignup.currentState?.validate() ?? false) {
                                                // signupViewModel.signUpUser();
                                                signupViewModel.userSentOtp();
                                              }
                                            },
                                          ),
                                          CommonWidget.getFieldSpacer(height: 28),
                                          Align(
                                            alignment: Alignment.center,
                                            child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: buildTranslate(context, "alreadyHaveAnAccount"),
                                                  style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 15),
                                                ),
                                                WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                                TextSpan(
                                                  text: buildTranslate(context, 'login'),
                                                  style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      NavigatorHelper.removeAllAndOpen(const LoginScreen());
                                                    },
                                                ),
                                              ]),
                                            ),
                                          ),
                                          CommonWidget.getFieldSpacer(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (signupViewModel.signUpData.state == ApiState.LOADING || signupViewModel.sentOtp.state == ApiState.LOADING ) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
