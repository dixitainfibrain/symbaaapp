import 'dart:async';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:flutter/material.dart';

import '../Login/LoginScreen.dart';

class HomeViewModel extends ChangeNotifier {
  late BuildContext context;
  PageController pageController = PageController(initialPage: 0,);
  late Timer timer;
  int currentPage = 0;

  init(BuildContext context) async {
    this.context = context;
    startAutoScroll();
    notifyListeners();
  }

  void startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (pageController.hasClients) {
        currentPage = (currentPage + 1) % 2;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        notifyListeners();
      }
    });
  }


}
