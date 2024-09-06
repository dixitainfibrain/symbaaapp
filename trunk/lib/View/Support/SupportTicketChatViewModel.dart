import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportTicketChatViewModel extends ChangeNotifier{
  late BuildContext context;

  TextEditingController replyCtrl = TextEditingController();
  FocusNode replyFocus = FocusNode();

  init(BuildContext context) async{
    this.context = context;
    notifyListeners();
  }
}