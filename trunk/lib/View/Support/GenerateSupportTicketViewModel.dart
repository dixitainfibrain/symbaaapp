import 'package:flutter/material.dart';

class GenerateSupportTicketViewModel extends ChangeNotifier {
  late BuildContext context;

  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileNoCtrl = TextEditingController();
  TextEditingController iccidNoCtrl = TextEditingController();
  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode iccidFocus = FocusNode();
  FocusNode subjectFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  final formKeyTicket = GlobalKey<FormState>();

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }
}
