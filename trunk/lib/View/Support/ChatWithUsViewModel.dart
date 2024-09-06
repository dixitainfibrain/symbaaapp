import 'package:flutter/cupertino.dart';

class ChatWithUsViewModel extends ChangeNotifier{
  late BuildContext context;

  TextEditingController messageController = TextEditingController();
  FocusNode messageFocus = FocusNode();

  init(BuildContext context)async{
    this.context = context;
    notifyListeners();
  }
}