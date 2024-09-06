import 'package:flutter/material.dart';

class MyPlanViewModel extends ChangeNotifier {
  late BuildContext context;

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

}


