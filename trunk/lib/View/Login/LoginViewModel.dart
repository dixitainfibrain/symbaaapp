// ignore_for_file: use_build_context_synchronously

import 'package:Symbaa/Helper/AlertHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Model/ResponseModel/RegisterModel.dart';
import 'package:Symbaa/Network/ApiParam.dart';
import 'package:Symbaa/Repository/AuthenticationRepository.dart';
import 'package:Symbaa/Response/ApiResponse.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/Utils/NoInternetConnection.dart';
import 'package:Symbaa/View/BottomNavigationScreen/BottomNavigationScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppGlobal.dart';

class LoginViewModel extends ChangeNotifier {
  late BuildContext context;

  TextEditingController mobileOrEmailController = TextEditingController(text: "aag12@yopmail.com");
  TextEditingController passwordController = TextEditingController(text: "Test@1234");
  FocusNode fnMobileOrEmail = FocusNode();
  FocusNode fnPassword = FocusNode();
  final formKeyLogin = GlobalKey<FormState>();

  ValueNotifier<bool> isLoading = ValueNotifier(false);
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  ApiResponse<RegisterResponseModel?> userLoginData = ApiResponse.initial();

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  // TODO User Login
  Future<void> userLogin({bool? isSocial = false, String? emailId}) async {
    userLoginData = ApiResponse.loading();
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
      userLoginData = ApiResponse.noInternet();
      notifyListeners();
      return;
    }
    notifyListeners();
    Map<String, String> body = {
      ApiParam.checkEmail: mobileOrEmailController.text.toString(),
      ApiParam.password: passwordController.text,
    };
    try {
      var response = await authenticationRepository.userLogin(userDetails: body);
      userLoginData = ApiResponse.completed(response);
      if (userLoginData.data!.status ?? false) {
        userLoginData = ApiResponse.completed(response);
        AlertHelper.showAppSnackBar(context, message: userLoginData.data!.message ?? '');
        await SharedPref.savePreferenceValue(prefKeyUserModel, userLoginData.data?.registerData ?? RegisterResponseData());
        await SharedPref.savePreferenceValue(prefKeyIsLogin, true);
        NavigatorHelper.removeAllAndOpen(BottomNavigationScreen());
      } else {
        AlertHelper.showAppSnackBar(context, message: userLoginData.data!.message ?? '');
      }
      mobileOrEmailController.clear();
      passwordController.clear();
      notifyListeners();
    } catch (error) {
      AppGlobal.printLog('loginUser catch ==> $error');
      userLoginData = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
