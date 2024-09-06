import 'package:flutter/material.dart';

class OrderSummaryViewModel extends ChangeNotifier{
  late BuildContext context;

  TextEditingController promoCodeTextController = TextEditingController();
  FocusNode promoCodeFocus = FocusNode();

  init(BuildContext context) async{
    this.context = context;
    notifyListeners();
  }
}