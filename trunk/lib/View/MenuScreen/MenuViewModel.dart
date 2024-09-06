import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Login/LoginScreen.dart';

class MenuViewModel extends ChangeNotifier {
  late BuildContext context;
  String appVersion = "0.0";

  List<MenuItem> listCard = [];
  List<MenuItem> listMenu = [];

  init(BuildContext context) async {
    this.context = context;
    setCardList();
    setMenuList();
    getAppVersion();
    notifyListeners();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    appVersion = version;
    notifyListeners();
  }

  void setCardList() {
    listCard.add(MenuItem(index: 0, icon: 'ic_sim.svg', name: 'eSIM'));
    listCard.add(MenuItem(index: 1, icon: "ic_topup.svg", name: 'topup'));
    listCard.add(MenuItem(index: 2, icon: "ic_file.svg", name: 'history'));
  }

  void setMenuList() {
    listMenu.add(MenuItem(index: 0, icon: "ic_sim_card.svg", name: 'myPlans'));
    listMenu.add(MenuItem(index: 1, icon: "ic_faq.svg", name: 'faqGuide'));
    listMenu.add(MenuItem(index: 2, icon: "ic_support.svg", name: 'support'));
    listMenu.add(MenuItem(index: 3, icon: "ic_terms.svg", name: 'termsAndCondition'));
    listMenu.add(MenuItem(index: 4, icon: "ic_privacy.svg", name: 'privacyPolicy'));
  }
}

class MenuItem {
  int? index;
  String? name;
  String? icon;

  MenuItem({this.index, this.name, this.icon});
}
