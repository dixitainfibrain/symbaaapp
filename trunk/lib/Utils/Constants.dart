import 'package:flutter/material.dart';

const bool DEVELOPER_MODE = false;

String latitude = '';
String longitude = '';
const String bullet = '\u2022';

String ONESIGNAL_APP_ID = '11f4876c-83a1-4ba1-8638-1a2f33daf68f';
String tinyAuthToken = 'cUBYCCCVevkAHdtv7KQnDdqLcCR2rRYpEhyQZtKkGOjlXLDKmEnVMxZpGMQe';

const userRegisterType = '3';
const userRole = '2';

const int typeSolo = 1;
const int typeCompete = 2;
const int typeLocal = 3;

const int typeSubmitWords = 1;
const int typeInviteFriends = 2;

const String notificationTypeWordApprove = "20";

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

//=========ALL CONSTANTS VALUE FOR THE CODING===========

const String prefKeyToken = 'prefKeyToken';
const String prefKeyIsLogin = 'isLogin';
const String prefKeyLanguageCode = 'prefKeyLanguageCode';

const String heroLoginSignup = 'heroLoginSignup';
const String heroProfile = 'heroProfile';
const String heroProfileItem = 'heroProfileItem';
const String heroMenuItem = 'heroMenuItem';
const String heroPwdSuccess = 'heroPwdSuccess';

const String prefKeyUserModel = 'prefUserModel';



int itemPerPage = 10;

ValueNotifier<bool> isInternetAvailable = ValueNotifier<bool>(false);

extension Validator on String {

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()-+=])[A-Za-z\d!@#$%^&*()-+=]{6,20}$').hasMatch(this);
  }
}
