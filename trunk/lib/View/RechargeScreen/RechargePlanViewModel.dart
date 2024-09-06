import 'package:flutter/material.dart';

class RechargePlanViewModel extends ChangeNotifier{
  late BuildContext context;
  inti(BuildContext context) async{
    this.context = context;
    notifyListeners();
  }
}