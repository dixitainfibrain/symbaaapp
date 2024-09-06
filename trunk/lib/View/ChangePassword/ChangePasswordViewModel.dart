
import 'dart:convert';
import 'dart:io';
import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Model/ResponseModel/CommonStatusMsgModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/ResetPasswordSuccess/ResetPasswordSuccessScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../Custom/ImagePickerBottomSheet.dart';


class ChangePasswordViewModel extends ChangeNotifier {
  late BuildContext context;
  final formKeyChangePassword = GlobalKey<FormState>();

  TextEditingController currentPwdController = TextEditingController(text: "Test@1234");
  TextEditingController newPwdController = TextEditingController(text: "Test@12345");
  TextEditingController confirmPwdController = TextEditingController(text: "Test@12345");

  FocusNode fnCurrentPwd = FocusNode();
  FocusNode fnNewPwd = FocusNode();
  FocusNode fnConfirmPwd = FocusNode();

  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<CommonStatusMessageModel?> userChangePassword = ApiResponse.initial();

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  // TODO Change Password API
  Future<void> resetPassword() async {
    userChangePassword = ApiResponse.loading();
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
      userChangePassword = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: AppGlobal.userData?.user?.email ?? "",
      ApiParam.oldPassword: currentPwdController.text,
      ApiParam.password: newPwdController.text,
    };
    try {
      var response = await authenticationRepository.changePassword(userDetails: body);
      userChangePassword = ApiResponse.completed(response);
      if (userChangePassword.data!.status ?? false) {
        userChangePassword = ApiResponse.completed(response);
        AlertHelper.showAppSnackBar(context, message: userChangePassword.data!.message ?? '');
        currentPwdController.clear();
        newPwdController.clear();
        confirmPwdController.clear();
      } else {
        AlertHelper.showAppSnackBar(context, message: userChangePassword.data!.message ?? '');
      }
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      userChangePassword = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
