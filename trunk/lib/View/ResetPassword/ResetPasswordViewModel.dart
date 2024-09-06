import 'dart:async';

import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Model/ResponseModel/CommonStatusMsgModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/ResetPasswordSuccess/ResetPasswordSuccessScreen.dart';
import 'package:flutter/material.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  late BuildContext context;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode fnPassword = FocusNode();
  FocusNode fnConfirmPassword = FocusNode();

  final formKeyResetPassword = GlobalKey<FormState>();
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<CommonStatusMessageModel?> userResetPassword = ApiResponse.initial();

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  // TODO Reset Password API
  Future<void> resetPassword(String email, String otp) async {
    userResetPassword = ApiResponse.loading();
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
      userResetPassword = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: email,
      ApiParam.password: newPasswordController.text,
      ApiParam.otp: otp,
    };
    try {
      var response = await authenticationRepository.resetPassword(userDetails: body);
      userResetPassword = ApiResponse.completed(response);
      if (userResetPassword.data!.status ?? false) {
        userResetPassword = ApiResponse.completed(response);
        AlertHelper.showAppSnackBar(context, message: userResetPassword.data!.message ?? '');
        NavigatorHelper.removeAllAndOpen(const ResetPasswordSuccessScreen());
      } else {
        AlertHelper.showAppSnackBar(context, message: userResetPassword.data!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      userResetPassword = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
