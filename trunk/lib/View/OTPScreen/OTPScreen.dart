import 'dart:async';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Style/Fonts.dart';
import 'package:Symbaa/Utils/ApiState.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/commonLoader.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/Custom/CustomAppBar.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/Regex.dart';
import '../../Helper/ValidationHelper.dart';
import '../../Style/AppTheme.dart';
import 'OTPViewModel.dart';

class OTPScreen extends StatefulWidget {
  bool? isEmailAuth;
  String? fromSignUp;
  String? email;
  String? phone;
  String? countryCode;
  String? password;
  String? firstName;
  String? lastname;
  String? referralCode;

  OTPScreen({this.isEmailAuth, this.fromSignUp, this.email, this.phone, this.countryCode, this.password, this.referralCode, this.firstName, this.lastname, super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with SingleTickerProviderStateMixin {
  OTPViewModel otpViewModel = OTPViewModel();
  int start = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    otpViewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => otpViewModel,
      child: Consumer<OTPViewModel>(
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
                        !otpViewModel.isMobile
                            ? Positioned(
                                top: 10,
                                left: 50,
                                right: 40,
                                child: Container(
                                  height: 250,
                                  width: MediaQuery.sizeOf(context).width,
                                  color: AppColor.appBlackColor,
                                  child: AssetsHelper.getAssetImage(
                                    name: 'img_otp2.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 50,
                                left: 80,
                                right: 80,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  color: AppColor.appBlackColor,
                                  child: AssetsHelper.getAssetImage(
                                    name: 'img_otp1.png',
                                    fit: BoxFit.cover,
                                  ),
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
                                    physics: const ClampingScrollPhysics(),
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 0, bottom: 80),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 55),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CommonWidget.getFieldSpacer(height: 28),
                                              Text(
                                                buildTranslate(context, 'oneTimePassword'),
                                                style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 23),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 8),
                                              Text(
                                                buildTranslate(context, 'enterThe6DigitCodeThatWeHaveSentToThe'),
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appWhiteColor, fontSize: 15),
                                              ),
                                              Text(
                                                // (widget.isEmailAuth ?? false)
                                                otpViewModel.isMobile ? "${widget.countryCode} ${widget.phone.toString()}" : widget.email.toString(),
                                                textAlign: TextAlign.center,
                                                style: Fonts.textStyleRegular.copyWith(color: AppColor.appColorYellow, fontSize: 15),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 35),
                                              Form(
                                                key: otpViewModel.formKey,
                                                child: Pinput(
                                                  length: 6,
                                                  // enabled: otpViewModel.otpSend,
                                                  enabled: true,
                                                  inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.allow(Regex.onlyDigits)],
                                                  obscureText: false,
                                                  autofillHints: const [AutofillHints.oneTimeCode],
                                                  obscuringWidget: Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColor.appSecondaryColor,
                                                    ),
                                                  ),
                                                  defaultPinTheme: otpViewModel.defaultPinTheme,
                                                  focusedPinTheme: otpViewModel.defaultPinTheme.copyWith(
                                                    decoration: otpViewModel.defaultPinTheme.decoration?.copyWith(
                                                      border: Border.all(color: AppColor.appSecondaryColor),
                                                    ),
                                                  ),
                                                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, 'otpValidation'),
                                                  closeKeyboardWhenCompleted: true,
                                                  controller: otpViewModel.pinController,
                                                  focusNode: otpViewModel.pinPutFocusNode,
                                                  useNativeKeyboard: true,
                                                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                                  showCursor: true,
                                                  cursor: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Divider(
                                                          height: 10,
                                                          color: AppColor.appSecondaryColor,
                                                          thickness: 2,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              CommonWidget.getFieldSpacer(height: 18),
                                              Row(
                                                children: [
                                                  Visibility(
                                                    visible: !(otpViewModel.isEnableResendBtn ?? true),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AssetsHelper.getSVGIcon("ic_clock.svg"),
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                        CommonWidget.getFieldSpacer(width: 3),
                                                        Text(
                                                          otpViewModel.getResendCount(),
                                                          textAlign: TextAlign.center,
                                                          style: Fonts.textStyleSemiBold.copyWith(fontSize: 12.7, color: AppColor.appWhiteColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      otpViewModel.startTimer();
                                                      otpViewModel.resendEmailOtp(widget.email.toString());
                                                    },
                                                    child: Visibility(
                                                      visible: otpViewModel.isEnableResendBtn ?? false,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(top: 5),
                                                            child: SvgPicture.asset(
                                                              AssetsHelper.getSVGIcon("ic_resend.svg"),
                                                              height: 25,
                                                              width: 25,
                                                            ),
                                                          ),
                                                          CommonWidget.getFieldSpacer(width: 3),
                                                          Text(
                                                            buildTranslate(context, 'resendOTP'),
                                                            textAlign: TextAlign.center,
                                                            style: Fonts.textStyleSemiBold.copyWith(fontSize: 15, color: AppColor.appWhiteColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              CommonWidget.getFieldSpacer(height: 40),
                                              /// Skip phone Authentication
                                              Visibility(
                                                visible: otpViewModel.isMobile,
                                                replacement: const SizedBox(),
                                                child: InkWell(
                                                  onTap: () {
                                                    otpViewModel.signUpUser(
                                                      email: widget.email.toString(),
                                                      referralCode: widget.referralCode,
                                                      password: widget.password,
                                                      lastName: widget.lastname,
                                                      firstName: widget.firstName,
                                                      countryCode: widget.countryCode,
                                                      mobileNumber: widget.phone,
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        buildTranslate(context, 'skip'),
                                                        style: Fonts.textStyleSemiBold.copyWith(color: AppColor.appWhiteColor, fontSize: 18, fontWeight: FontWeight.w600),
                                                      ),
                                                      CommonWidget.getFieldSpacer(height: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              ButtonView(
                                                buttonTextName: buildTranslate(context, 'submit').toUpperCase(),
                                                onPressed: () async {
                                                  otpViewModel.isMobile
                                                      ? otpViewModel.verifyMobileOTP(
                                                          redirection: widget.fromSignUp.toString(),
                                                          email: widget.email.toString(),
                                                          referralCode: widget.referralCode,
                                                          password: widget.password,
                                                          lastName: widget.lastname,
                                                          firstName: widget.firstName,
                                                          countryCode: widget.countryCode,
                                                          phoneNumber: widget.phone,
                                                        )
                                                      : otpViewModel.verifyEmailOtp(widget.email.toString(), widget.phone.toString(), widget.countryCode.toString(),widget.fromSignUp.toString());
                                                },
                                              ),
                                              CommonWidget.getFieldSpacer(height: 50),
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
              if (otpViewModel.userResendOtpData.state == ApiState.LOADING || otpViewModel.userVerifyOtpData.state == ApiState.LOADING) commonLoader(context),
            ],
          );
        },
      ),
    );
  }
}
