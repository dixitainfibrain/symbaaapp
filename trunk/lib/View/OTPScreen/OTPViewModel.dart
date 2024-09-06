// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/FirebaseHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Model/ResponseModel/CommonStatusMsgModel.dart';
import 'package:Symbaa/Model/ResponseModel/RegisterModel.dart';
import 'package:Symbaa/Model/ResponseModel/ResendOtpModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/BottomNavigationScreen/BottomNavigationScreen.dart';
import 'package:Symbaa/View/ResetPassword/ResetPasswordScren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';

class OTPViewModel extends ChangeNotifier {
  late BuildContext context;
  final formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  FocusNode pinPutFocusNode = FocusNode();
  String? remainTime = "00:00";
  bool? isEnableResendBtn = false;

  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<ResendOtpResponseModel?> userResendOtpData = ApiResponse.initial();
  ApiResponse<CommonStatusMessageModel?> userVerifyOtpData = ApiResponse.initial();
  ApiResponse<RegisterResponseModel?> signUpData = ApiResponse.initial();

  var isMobile = false;
  String verificationOtpId = "";
  String otpForPassToReset = "";

  int start = 60;
  Timer? timer;

  init(BuildContext context) async {
    this.context = context;
    isMobile = false;
    startTimer();
    notifyListeners();
  }

  changeHeading() {
    isMobile = !isMobile;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  PinTheme defaultPinTheme = PinTheme(
    margin: const EdgeInsets.all(2),
    height: 50,
    width: 120,
    padding: EdgeInsets.zero,
    textStyle: Fonts.textStyleBold.copyWith(fontSize: 18, color: AppColor.appWhiteColor),
    decoration: BoxDecoration(
      color: AppColor.appPrimaryLightColor,
      border: Border.all(color: AppColor.appCurveBorderColor),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  void startTimer() {
    isEnableResendBtn = false;
    refresh();
    start = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        isEnableResendBtn = true;
        refresh();
        timer.cancel();
      } else {
        start--;
        refresh();
      }
    });
  }

  String getResendCount() {
    String time = start < 10 ? "0$start" : "$start";
    return "00:" "$time";
  }

  // TODO Mobile Number OTP Verify
  Future<void> verifyMobileOTP({
    String? redirection,
    String? email,
    String? countryCode,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? password,
    String? referralCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationOtpId, smsCode: pinController.text);
      FirebaseHelper.auth.signInWithCredential(credential).then((response) async {
        if (redirection == "SignUp") {
          await signUpUser(
            countryCode: countryCode,
            email: email,
            firstName: firstName,
            lastName: lastName,
            mobileNumber: phoneNumber,
            password: phoneNumber,
            referralCode: referralCode,
          );
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email, otp: otpForPassToReset)));
        }
        pinController.clear();
      }, onError: (error) {
        debugPrint("Firebase Error :: $error");
      });
    } on FirebaseAuthException catch (error) {
      notifyListeners();
      AlertHelper.showAppSnackBar(context, message: error.message.toString());
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  // TODO SignUp User
  Future<void> signUpUser({String? firstName, String? lastName, String? email, String? countryCode, String? mobileNumber, String? password, String? referralCode}) async {
    signUpData = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      await Future.delayed(const Duration(seconds: 1));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const NoInternetConnection();
        },
      );
      signUpData = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    Map<String, String> body = {
      ApiParam.firstName: firstName ?? "",
      ApiParam.lastName: lastName ?? "",
      ApiParam.email: email ?? "",
      ApiParam.mobile: "$countryCode $mobileNumber",
      ApiParam.password: password ?? "",
      ApiParam.referralCode: referralCode ?? "",
    };
    try {
      var response = await authenticationRepository.userRegistration(userDetails: body);
      signUpData = ApiResponse.completed(response);
      if (signUpData.data!.status ?? false) {
        await SharedPref.savePreferenceValue(prefKeyUserModel, signUpData.data?.registerData ?? RegisterResponseData());
        await SharedPref.savePreferenceValue(prefKeyIsLogin, true);
        AlertHelper.showAppSnackBar(context, message: response!.message ?? '');
        NavigatorHelper.removeAllAndOpen(BottomNavigationScreen());
      } else {
        AlertHelper.showAppSnackBar(context, message: response!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('signUpUser catch ==> $error');
      signUpData = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  // TODO Send Mobile OTP
  Future<void> sendMobileOTP(String phoneNumber, String countryCode) async {
    await FirebaseHelper.auth.verifyPhoneNumber(
      phoneNumber: "$countryCode $phoneNumber",
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        verificationOtpId = verificationId;
        changeHeading(); // change email to mobile
        startTimer();
        userVerifyOtpData = ApiResponse.initial();
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // TODO Email OTP Verify
  Future<void> verifyEmailOtp(String email, String phoneNumber, String countryCode, String forRegistration) async {
    userVerifyOtpData = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      await Future.delayed(const Duration(seconds: 1));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const NoInternetConnection();
        },
      );
      userVerifyOtpData = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, dynamic> body = {
      ApiParam.checkEmail: email,
      ApiParam.otp: pinController.text,
      ApiParam.isRegistration: forRegistration == "SignUp" ? true : false,
    };
    try {
      var response = await authenticationRepository.verifyOtp(userDetails: body);
      userVerifyOtpData = ApiResponse.completed(response);
      if (userVerifyOtpData.data!.status ?? false) {
        userVerifyOtpData = ApiResponse.completed(response);
        otpForPassToReset = pinController.text;
        pinController.clear();
        AlertHelper.showAppSnackBar(context, message: userVerifyOtpData.data!.message ?? '');
        userVerifyOtpData = ApiResponse.loading();
        await sendMobileOTP(phoneNumber, countryCode);
      } else {
        AlertHelper.showAppSnackBar(context, message: userVerifyOtpData.data!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      userVerifyOtpData = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  // TODO Resend OTP If Not Get
  Future<void> resendEmailOtp(String email) async {
    userResendOtpData = ApiResponse.loading();
    notifyListeners();
    if (!isInternetAvailable.value) {
      await Future.delayed(const Duration(seconds: 1));
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const NoInternetConnection();
        },
      );
      userResendOtpData = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: email,
    };
    try {
      var response = await authenticationRepository.userResendOtp(userDetails: body);
      userResendOtpData = ApiResponse.completed(response);
      if (userResendOtpData.data!.status ?? false) {
        userResendOtpData = ApiResponse.completed(response);
        pinController.clear();
        AlertHelper.showAppSnackBar(context, message: userResendOtpData.data!.message ?? '');
      } else {
        AlertHelper.showAppSnackBar(context, message: userResendOtpData.data!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      userResendOtpData = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
