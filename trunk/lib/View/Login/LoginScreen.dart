import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/ApiState.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/commonLoader.dart';
import 'package:Symbaa/View/BottomNavigationScreen/BottomNavigationScreen.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomAppBar.dart';
import 'package:Symbaa/View/Custom/CustomTextField.dart';
import 'package:Symbaa/View/ForgotPassword/ForgotPassword.dart';
import 'package:Symbaa/View/Signup/SignupScreen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Style/AppTheme.dart';
import 'LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    loginViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => loginViewModel,
      child: Consumer<LoginViewModel>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomAppBar(
                  backgroundColor: AppColor.appBlackColor,
                  onBackPressed: () {},
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
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Container(
                    color: AppColor.appBlackColor,
                    height: MediaQuery.sizeOf(context).height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: AppColor.appBlackColor,
                            child: AssetsHelper.getAssetImage(name: 'img_login.png', fit: BoxFit.contain, height: 275.0),
                          ),
                        ),
                        Positioned(
                          top: 282,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Hero(
                            tag: heroLoginSignup,
                            child: Material(
                              color: Colors.transparent,
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
                                            cornerRadius: 25,
                                            cornerSmoothing: 0.5,
                                          ))),
                                ),
                                padding: const EdgeInsets.only(top: 0),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: Form(
                                        key: loginViewModel.formKeyLogin,
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 55),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CommonWidget.getFieldSpacer(height: 28),
                                              Text(
                                                buildTranslate(context, 'login'),
                                                style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 8),
                                              Text(
                                                buildTranslate(context, 'welcomeBack'),
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 16),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 28),
                                              CustomTextField(
                                                tecController: loginViewModel.mobileOrEmailController,
                                                focusNode: loginViewModel.fnMobileOrEmail,
                                                hintText: buildTranslate(context, 'hintEmailOrMobile'),
                                                labelText: "${buildTranslate(context, 'labelEmailOrMobile')}*",
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return buildTranslate(context, 'pleaseEnterMobileOrEmail');
                                                  }
                                                  // Determine if the input is an email or phone number
                                                  final isEmail = RegExp(r'^[A-Za-z]+$').hasMatch(value);
                                                  final isPhoneNumber = RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);

                                                  if (isEmail) {
                                                    return ValidationHelper.checkEmailValidation(context, value);
                                                  } else if (isPhoneNumber) {
                                                    return ValidationHelper.checkMobileNoValidation(context, value);
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              CustomTextField(
                                                tecController: loginViewModel.passwordController,
                                                focusNode: loginViewModel.fnPassword,
                                                hintText: buildTranslate(context, 'hintPassword'),
                                                labelText: "${buildTranslate(context, 'labelPassword')}*",
                                                validator: (value) {
                                                  return ValidationHelper.checkBlankValidation(context, value, 'pleaseEnterPassword');
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                                                },
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    buildTranslate(context, 'forgotPassword_'),
                                                    style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              ButtonView(
                                                buttonTextName: buildTranslate(context, 'login').toUpperCase(),
                                                vnIsShowLoader: loginViewModel.isLoading,
                                                onPressed: () async {
                                                  NavigatorHelper.removeAllAndOpen(BottomNavigationScreen());
                                                  // if (loginViewModel.formKeyLogin.currentState?.validate() ?? false) {
                                                  //   loginViewModel.userLogin();
                                                  // }
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: buildTranslate(context, "firstTimeHere"),
                                                    style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 15),
                                                  ),
                                                  WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                                  TextSpan(
                                                    text: buildTranslate(context, 'signup'),
                                                    style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // NavigatorHelper().add(const SignupScreen(),animationType:  AnimationType.slideUp);
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
                                                      },
                                                  ),
                                                ]),
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
              if (loginViewModel.userLoginData.state == ApiState.LOADING) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
