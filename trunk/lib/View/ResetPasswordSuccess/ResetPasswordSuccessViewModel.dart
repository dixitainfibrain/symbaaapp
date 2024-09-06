import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:flutter/material.dart';

class ResetPasswordSuccessViewModel extends ChangeNotifier {
  late BuildContext context;

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
