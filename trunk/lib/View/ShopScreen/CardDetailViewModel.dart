
import 'package:flutter/material.dart';

class CardDetailViewModel extends ChangeNotifier{
  late BuildContext context;
  var selectCard = "";
  init(BuildContext context) async{
    this.context = context;
    notifyListeners();
  }
}