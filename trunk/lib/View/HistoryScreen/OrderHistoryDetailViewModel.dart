import 'package:flutter/cupertino.dart';

class OrderHistoryDetailViewModel extends ChangeNotifier{
  late BuildContext context;

  init(BuildContext context)async{
    this.context = context;
    notifyListeners();
  }
}