// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Model/ResponseModel/CommonStatusMsgModel.dart';
import 'package:Symbaa/Model/ResponseModel/RegisterModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/BottomNavigationScreen/BottomNavigationScreen.dart';
import 'package:Symbaa/View/OTPScreen/OTPScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupViewModel extends ChangeNotifier {
  late BuildContext context;

  TextEditingController firstNameController = TextEditingController(text: "aa");
  TextEditingController lastNameController = TextEditingController(text: "aa");
  TextEditingController emailController = TextEditingController(text: "aag12@yopmail.com");
  TextEditingController mobileController = TextEditingController(text: "1234567890");
  TextEditingController passwordController = TextEditingController(text: "Test@123");
  TextEditingController confirmPasswordController = TextEditingController(text: "Test@123");
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FocusNode fnFirstName = FocusNode();
  FocusNode fnLastName = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnMobile = FocusNode();
  FocusNode fnPassword = FocusNode();
  FocusNode fnConfirmPassword = FocusNode();
  FocusNode fnReferralCode = FocusNode();

  var countryCode = "+91";
  var countryPhoneLength = 10;

  final formKeySignup = GlobalKey<FormState>();

  var otpVerificationId = "";

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<RegisterResponseModel?> signUpData = ApiResponse.initial();
  ApiResponse<CommonStatusMessageModel?> sentOtp = ApiResponse.initial();

  // TODO Assign Country Code
  void selectCountryCode(String code){
    countryCode = code;
    notifyListeners();
  }

  // TODO Sent for OTP
  // TODO Email OTP Verify
  Future<void> userSentOtp() async {
    sentOtp = ApiResponse.loading();
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
      sentOtp = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: emailController.text,
    };
    try {
      var response = await authenticationRepository.sentOtp(userDetails: body);
      sentOtp = ApiResponse.completed(response);
      if (sentOtp.data!.status ?? false) {
        sentOtp = ApiResponse.completed(response);
        AlertHelper.showAppSnackBar(context, message: sentOtp.data!.message ?? '');
        NavigatorHelper().add(OTPScreen(
          fromSignUp: "SignUp",
          isEmailAuth: false,
          email: emailController.text,
          phone: mobileController.text,
          countryCode: countryCode,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastname: lastNameController.text,
          referralCode: referralCodeController.text,
        ));
      } else {
        AlertHelper.showAppSnackBar(context, message: sentOtp.data!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      sentOtp = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  // // TODO SignUp User
  // Future<void> signUpUser() async {
  //   signUpData = ApiResponse.loading();
  //   notifyListeners();
  //   if (!isInternetAvailable.value) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return const NoInternetConnection();
  //       },
  //     );
  //     signUpData = ApiResponse.noInternet();
  //     notifyListeners();
  //     return;
  //   }
  //   Map<String, String> body = {
  //     ApiParam.firstName: firstNameController.text,
  //     ApiParam.lastName: lastNameController.text,
  //     ApiParam.email: emailController.text,
  //     ApiParam.mobile: "$countryCode ${mobileController.text}",
  //     ApiParam.password: passwordController.text,
  //     ApiParam.referralCode: referralCodeController.text,
  //   };
  //   try {
  //     var response = await authenticationRepository.userRegistration(userDetails: body);
  //     signUpData = ApiResponse.completed(response);
  //     if (signUpData.data!.status ?? false) {
  //       await SharedPref.savePreferenceValue(prefKeyUserModel, signUpData.data?.registerData ?? RegisterResponseData());
  //       await SharedPref.savePreferenceValue(prefKeyIsLogin, true);
  //       AlertHelper.showAppSnackBar(context, message: response!.message ?? '');
  //       /// Navigate to the OTP VerifyScreen
  //       NavigatorHelper().add(OTPScreen(
  //         fromSignUp: "SignUp",
  //         isEmailAuth: false,
  //         email: emailController.text,
  //         phone: mobileController.text,
  //         countryCode: countryCode,
  //       ));
  //     } else {
  //       AlertHelper.showAppSnackBar(context, message: response!.message ?? '');
  //     }
  //     notifyListeners();
  //   } catch (error) {
  //     AppGlobal.printLog('signUpUser catch ==> $error');
  //     signUpData = ApiResponse.error(error.toString());
  //     notifyListeners();
  //   }
  // }
}
