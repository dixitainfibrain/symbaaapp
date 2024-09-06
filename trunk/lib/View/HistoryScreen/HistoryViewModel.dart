import 'package:flutter/material.dart';

class HistoryViewModel extends ChangeNotifier {
  late BuildContext context;

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }

}
