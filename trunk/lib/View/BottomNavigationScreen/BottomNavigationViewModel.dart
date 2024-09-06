import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/View/HistoryScreen/HistoryScreen.dart';
import 'package:Symbaa/View/MenuScreen/MenuScreen.dart';
import 'package:Symbaa/View/ProfileScreen/ProfileScreen.dart';
import 'package:Symbaa/View/RechargeScreen/RechargeScreen.dart';
import 'package:Symbaa/View/ShopScreen/ShopScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Utils/AppGlobal.dart';
import '../HomeScreen/HomeScreen.dart';
import '../Login/LoginScreen.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  late BuildContext context;
  List<Widget> bottomNavScreenList = [];
  int selectedIndex = 2;

  init(BuildContext context,int selectedIndex) async {
    this.context = context;
    this.selectedIndex = selectedIndex;
    bottomNavScreenList.add(const HomeScreen());
    bottomNavScreenList.add(const RechargeScreen());
    bottomNavScreenList.add(const ShopScreen());
    bottomNavScreenList.add(const HistoryScreen());
    bottomNavScreenList.add(const MenuScreen());

    AppGlobal.bottomNavigationIndex.addListener(() {
      if(AppGlobal.bottomNavigationIndex.value == 5){
        selectedIndex = 5;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  changeIndex(value) async {
    selectedIndex = value;
    AppGlobal.bottomNavigationIndex.value = value;
    AppGlobal.getUserDataFromLocal();
    notifyListeners();
  }
}
