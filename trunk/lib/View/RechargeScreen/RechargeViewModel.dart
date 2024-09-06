import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:flutter/material.dart';

import '../Login/LoginScreen.dart';

class RechargeViewModel extends ChangeNotifier {
  late BuildContext context;

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }



}
