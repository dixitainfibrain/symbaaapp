import 'package:flutter/material.dart';

class FAQViewModel extends ChangeNotifier {
  late BuildContext context;
  List<FAQItem> listFAQItem = [];
  int? selectedItemIndex;

  init(BuildContext context) async {
    this.context = context;
    setListItem();
    notifyListeners();
  }

  refresh() {
    notifyListeners();
  }

  void toggleExpansion(int index) {
    for (int i = 0; i < listFAQItem.length; i++) {
      if(i != index){
        listFAQItem[i].isExpanded = false;
      }
      else{
        listFAQItem[i].isExpanded = !(listFAQItem[i].isExpanded ?? true);
      }

    }
    notifyListeners();
  }

  setListItem() {
    for (int i = 0; i < 6; i++) {
      listFAQItem.add(FAQItem(
        id: i + 1,
        title: "I am not able to receive calls and sms what do I do?",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
        isExpanded: false,
      ));
    }
    notifyListeners();
  }
}

class FAQItem {
  int? id;
  String? title;
  String? description;
  bool? isExpanded;

  FAQItem({this.id, this.title, this.description, this.isExpanded});
}
