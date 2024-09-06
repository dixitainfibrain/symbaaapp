import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/OneSignalNotificationHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/BottomNavigationScreen/BottomNavigationScreen.dart';
import 'package:flutter/material.dart';

import '../Login/LoginScreen.dart';

class SplashViewModel extends ChangeNotifier {
  late BuildContext context;

  init(BuildContext context) async {
    this.context = context;

    notifyListeners();
  }


  void navigationPage() async {
    // NavigatorHelper.removeAllAndOpen(const LoginScreen());
    // await OneSignalNotificationHelper().initialize();
    bool isLoggedIn = await SharedPref.isLoggedIn();
    if(isLoggedIn){
      AppGlobal.getUserDataFromLocal();
      NavigatorHelper.removeAllAndOpen(BottomNavigationScreen());
    }else{
      NavigatorHelper.removeAllAndOpen(const LoginScreen());
    }
  }
}
