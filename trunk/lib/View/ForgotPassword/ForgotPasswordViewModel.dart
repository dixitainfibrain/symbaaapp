// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Model/ResponseModel/ResendOtpModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/OTPScreen/OTPScreen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  late BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  FocusNode fnEmail = FocusNode();
  FocusNode fnMobile = FocusNode();

  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<ResendOtpResponseModel?> userForgotVerifyData = ApiResponse.initial();

  final formKeyForgotPassword = GlobalKey<FormState>();

  var countryCode = "+91";
  var countryPhoneLength = 10;

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // TODO Assign Country Code
  void selectCountryCode(String code){
    countryCode = code;
    notifyListeners();
  }


  /// verify Email And Mobile Number for Forgot password
  Future<void> sendEmailAndMobile() async {
    userForgotVerifyData = ApiResponse.loading();
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
      userForgotVerifyData = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: emailController.text,
      ApiParam.mobile: "$countryCode ${mobileController.text}",
    };
    try{
      var response = await authenticationRepository.userSendEmailAndMobile(userDetails: body);
      userForgotVerifyData = ApiResponse.completed(response);
      if (userForgotVerifyData.data!.status ?? false) {
        userForgotVerifyData = ApiResponse.completed(response);
        AlertHelper.showAppSnackBar(context, message:  userForgotVerifyData.data!.message ?? '');
        NavigatorHelper().add(OTPScreen(
          fromSignUp: "Reset",
          isEmailAuth: false,
          email: emailController.text,
          phone: mobileController.text,
          countryCode: countryCode,
        ));
      }else{
        AlertHelper.showAppSnackBar(context, message:  userForgotVerifyData.data!.message ?? '');
      }
      notifyListeners();
    } catch(error){
      AppGlobal.printLog('loginUser catch ==> $error');
      userForgotVerifyData = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

}
