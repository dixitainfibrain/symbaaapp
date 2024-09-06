import 'package:Symbaa/Model/ResponseModel/CommonStatusMsgModel.dart';
import 'package:Symbaa/Model/ResponseModel/RegisterModel.dart';
import 'package:Symbaa/Model/ResponseModel/ResendOtpModel.dart';
import 'package:Symbaa/Network/AppUrl.dart';
import 'package:Symbaa/Network/NetworkApiServices.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';

class AuthenticationRepository{
  final NetworkApiServices _apiServices = NetworkApiServices();


  // TODO User Registration
  Future<RegisterResponseModel?> userRegistration({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.register, userDetails);

      RegisterResponseModel userRegistrationData = RegisterResponseModel.fromJson(response);
      if(userRegistrationData.status!) {
        return userRegistrationData;
      } else {
        return userRegistrationData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO User Registration
  Future<RegisterResponseModel?> userLogin({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.login, userDetails);

      RegisterResponseModel userRegistrationData = RegisterResponseModel.fromJson(response);
      if(userRegistrationData.status!) {
        return userRegistrationData;
      } else {
        return userRegistrationData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO User Resend OTP
  Future<ResendOtpResponseModel?> userResendOtp({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.resendOtp, userDetails);

      ResendOtpResponseModel userRegistrationData = ResendOtpResponseModel.fromJson(response);
      if(userRegistrationData.status!) {
        return userRegistrationData;
      } else {
        return userRegistrationData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO User Send Email And Mobile For Forgot
  Future<ResendOtpResponseModel?> userSendEmailAndMobile({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.forgot, userDetails);

      ResendOtpResponseModel userRegistrationData = ResendOtpResponseModel.fromJson(response);
      if(userRegistrationData.status!) {
        return userRegistrationData;
      } else {
        return userRegistrationData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO Verify OTP
  Future<CommonStatusMessageModel?> verifyOtp({required Map<String, dynamic> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.verifyOtp, userDetails);

      CommonStatusMessageModel userVerifyData = CommonStatusMessageModel.fromJson(response);
      if(userVerifyData.status!) {
        return userVerifyData;
      } else {
        return userVerifyData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO Reset Password
  Future<CommonStatusMessageModel?> resetPassword({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.reset, userDetails);
      CommonStatusMessageModel userVerifyData = CommonStatusMessageModel.fromJson(response);
      if(userVerifyData.status!) {
        return userVerifyData;
      } else {
        return userVerifyData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO Change Password
  Future<CommonStatusMessageModel?> changePassword({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.change, userDetails);
      CommonStatusMessageModel userChangePassword = CommonStatusMessageModel.fromJson(response);
      if(userChangePassword.status!) {
        return userChangePassword;
      } else {
        return userChangePassword;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }

  // TODO Sent OTP
  Future<CommonStatusMessageModel?> sentOtp({required Map<String, String> userDetails}) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.sentOtp, userDetails);

      CommonStatusMessageModel userSentOtpData = CommonStatusMessageModel.fromJson(response);
      if(userSentOtpData.status!) {
        return userSentOtpData;
      } else {
        return userSentOtpData;
      }
    } catch (e, st) {
      AppGlobal.printLog('userRegistration error ==> ${e.toString()} $st');
      rethrow;
    }
  }
}