
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../Model/ResponseModel/RegisterModel.dart';
import 'Constants.dart';

class AppGlobal {
  static RegisterResponseData? userData;
  static String selectedLanguageCode = "en-US";
  static String verificationId = "";
  static int resendToken = 0;
  static String defaultCountryCode = "1";
  static String contactNo = "9343000111";
  static String token = '';
  static String refreshToken = '';
  static int slugPrivacyID = 18;
  static int slugTermsID = 17;
  static String faqUrl = 'https://www.google.com/';
  String state = '', city = '';
  static ValueNotifier<String> smsMessage = ValueNotifier("");
  static ValueNotifier<int> bottomNavigationIndex = ValueNotifier(0);
  static ValueNotifier<bool> isShowBottomNav = ValueNotifier(true);

  bool isUserNotLogin = false;
  static double notchSize = 26.0;
  static int itemPerPage = 10;

  static ValueNotifier<int> get bottomNavigationIndexVal => bottomNavigationIndex;

  static String get authToken => token;

  String get getState => state;

  String get getCity => city;

  static getUserDataFromLocal() async {
    String userDataString = await SharedPref.readPreferenceValue(prefKeyUserModel, PrefEnum.STRING) ?? '';
    debugPrint("getUserData ==> $userDataString");
    if (userDataString.isNotEmpty) {
      Map<String, dynamic> map = jsonDecode(userDataString);
      if (map.isNotEmpty) {
        RegisterResponseData userDetails = RegisterResponseData.fromJson(map);
        token = userDetails.accessToken ?? "";
        userData = userDetails;
      }
    }
  }

  static Future<bool> isUserLogin() async {
    return false;
  }

  static void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(navigatorKey.currentContext!);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }

  static appLogout() async {

  }

  static Widget getFieldSpacer({double? height, double? width}) {
    return SizedBox(
      height: height ?? 10.0,
      width: width ?? 0.0,
    );
  }

  static printLog(dynamic val) {
    // log(val.toString());
    print("print ======> ${val.toString()}");
  }

  static double getTwoDecimalValue(double amount) {
    num mod = math.pow(10.0, 2);
    return ((amount * mod).round().toDouble() / mod);
  }

  static bool hasNotch(BuildContext context) {
    if (Platform.isIOS && MediaQuery.of(context).padding.bottom > 0) {
      return true;
    } else {
      return false;
    }
  }

}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
