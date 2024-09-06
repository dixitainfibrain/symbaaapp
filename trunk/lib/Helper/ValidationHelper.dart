import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:flutter/cupertino.dart';

import 'Regex.dart';

class ValidationHelper {
  static checkEmailValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return buildTranslate(context, "pleaseEnterEmail");
    } else if (value.isNotEmpty && !Regex.email.hasMatch(value.trim())) {
      return buildTranslate(context, "invalidEmailAddress");
    } else {
      return null;
    }
  }

  static checkMobileNoValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return buildTranslate(context, "pleaseEnterMobileNo");
    } else if (value.length < 10) {
      return buildTranslate(context, "invalidMobile");
    } else {
      return null;
    }
  }

  static checkPhoneNoValidation(BuildContext context, String value) {
    if (value.isEmpty) {
      return buildTranslate(context, "pleaseEnterPhoneNo");
    } else if (value.length < 10) {
      return buildTranslate(context, "invalidPhone");
    } else {
      return null;
    }
  }

  static checkBlankValidation(BuildContext context, String value, String errorMessageKey) {
    if (value.isEmpty) {
      return buildTranslate(context, errorMessageKey);
    } else {
      return null;
    }
  }

  static checkPasswordValidation(BuildContext context, String value, String errorMessageKey) {
    if (value.isEmpty) {
      return buildTranslate(context, errorMessageKey);
    } else if (value.toString().trim().length < 8) {
      return buildTranslate(context, "passwordMinimumValidation");
    } else if (!Regex.password.hasMatch(value)) {
      return buildTranslate(context, "pleaseEnterValidPassword");
    } else {
      return null;
    }
  }

  static checkConfirmPasswordValidation(BuildContext context, String value, String passwordMatch) {
    if (value.isEmpty) {
      return buildTranslate(context, "pleaseReEnterPassword");
    } else if (value.isNotEmpty && value != passwordMatch) {
      return buildTranslate(context, "passwordMatchValidation");
    } else {
      return null;
    }
  }


  static checkConfirmChangePasswordValidation(BuildContext context, String value, String passwordMatch) {
    if (value.isEmpty) {
      return buildTranslate(context, "pleaseEnterConfirmPassword");
    } else if (value.isNotEmpty && value != passwordMatch) {
      return buildTranslate(context, "passwordMatchValidation");
    } else {
      return null;
    }
  }

}
