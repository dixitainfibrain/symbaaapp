import 'dart:async';

import 'package:flutter/material.dart';

class ShopViewModel extends ChangeNotifier{
  late BuildContext context;
  var isSearch = false;
  var fee = false;
  var filterList = ["Top Destination","Full Countries","Regional","Promo Destinations","Global"];
  var selectedFilterList = [];
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  late Timer timer;
  TextEditingController shopSearchController = TextEditingController();
  FocusNode shopSearchFocus = FocusNode();

  init(BuildContext context) async{
    this.context = context;
    startAutoScroll();
    notifyListeners();
  }
  activeSearch(){
    isSearch = !isSearch;
    notifyListeners();
  }

  feeTypeChange(){
    fee = !fee;
    notifyListeners();
  }

  addFilter(String item){
    if(selectedFilterList.contains(item)){
      selectedFilterList.remove(item);
    }else{
      selectedFilterList.add(item);
    }
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