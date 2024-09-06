import 'dart:async';

import 'package:Symbaa/Helper/FirebaseHelper.dart';
import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Helper/SharedPref.dart';
import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/Dialogs/CommonDialog.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Login/LoginScreen.dart';

class ProfileViewModel extends ChangeNotifier {
  late BuildContext context;
  final formKeyProfile = GlobalKey<FormState>();
  List<MenuItem> listMenu = [];

  init(BuildContext context) async {
    this.context = context;
    setMenuList();
    notifyListeners();
  }

  void setMenuList() {
    listMenu.add(MenuItem(index: 0, icon: "ic_user.svg", name: 'editProfile'));
    listMenu.add(MenuItem(index: 1, icon: "ic_change_pwd.svg", name: 'changePassword'));
    listMenu.add(MenuItem(index: 2, icon: "ic_delete_acc.svg", name: 'deleteAccount'));
    listMenu.add(MenuItem(index: 3, icon: "ic_logout.svg", name: 'logout'));
  }

  void showLogoutDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          title: buildTranslate(context, 'logout'),
          description: buildTranslate(context, 'logoutMsg'),
          onYesPressed: () async{
            Navigator.of(context).pop();
            FirebaseHelper.auth.signOut();
            await SharedPref.savePreferenceValue(prefKeyIsLogin, false);
            NavigatorHelper.removeAllAndOpen(const LoginScreen());
          },
          onNoPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void showDeleteAccountDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          title: buildTranslate(context, 'deleteAccount'),
          description: buildTranslate(context, 'deleteAccountMsg'),
          onYesPressed: () {
            Navigator.of(context).pop();
            NavigatorHelper.removeAllAndOpen(const LoginScreen());
          },
          onNoPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class MenuItem {
  int? index;
  String? name;
  String? icon;

  MenuItem({this.index, this.name, this.icon});
}

