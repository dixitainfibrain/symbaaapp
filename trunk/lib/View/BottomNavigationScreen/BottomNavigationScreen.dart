import 'package:Symbaa/Localization/languageSettings.dart';
import 'package:Symbaa/Utils/CommonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';
import '../../utils/AppGlobal.dart';
import 'BottomNavigationViewModel.dart';

class BottomNavigationScreen extends StatefulWidget {

  int selectedIndex = 2;
  BottomNavigationScreen({this.selectedIndex = 2,super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> with SingleTickerProviderStateMixin {
  BottomNavigationViewModel bottomNavigationViewModel = BottomNavigationViewModel();

  @override
  void initState() {
    super.initState();
    bottomNavigationViewModel.init(context,widget.selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => bottomNavigationViewModel,
      child: Consumer<BottomNavigationViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            bottomNavigationBar: buildBottomNavigation(),
            body: IndexedStack(
              index: bottomNavigationViewModel.selectedIndex,
              children: bottomNavigationViewModel.bottomNavScreenList,
            ),
          );
        },
      ),
    );
  }

  ChangeNotifierProvider<BottomNavigationViewModel> buildBottomNavigation() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => bottomNavigationViewModel,
      child: Consumer<BottomNavigationViewModel>(
        builder: (context, viewModel, _) {
          return ValueListenableBuilder(
            valueListenable: AppGlobal.isShowBottomNav,
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: AppColor.appWhiteColor,
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 82,
                  margin: EdgeInsets.only(bottom: AppGlobal.hasNotch(context) ? 15 : 2),
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 82,
                          width: MediaQuery.sizeOf(context).width / 5,
                          child: bottomMenuWidget(index),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget bottomMenuWidget(int index) {
    return GestureDetector(
      onTap: () {
        bottomNavigationViewModel.changeIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsHelper.getSVGIcon(getMenuIcon(index)),
          ),
          CommonWidget.getFieldSpacer(height: 8),
          Text(
            getMenuName(index),
            style: (bottomNavigationViewModel.selectedIndex == index)
                ? Fonts.textStyleBold.copyWith(
                    fontSize: 15,
                  )
                : Fonts.textStyleRegular.copyWith(
                    fontSize: 15,
                  ),
          ),
          CommonWidget.getFieldSpacer(height: 5),
          Visibility(
            visible: bottomNavigationViewModel.selectedIndex == index,
            replacement: Container(
              height: 4.5,
            ),
            child: Container(
              height: 4.5,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.sizeOf(context).width / 5,
              decoration: BoxDecoration(
                color: AppColor.appPrimaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getMenuIcon(int index) {
    if (index == 0) {
      return (bottomNavigationViewModel.selectedIndex == index) ? "ic_home_select.svg" : "ic_home.svg";
    } else if (index == 1) {
      return (bottomNavigationViewModel.selectedIndex == index) ? "ic_recharge_select.svg" : "ic_recharge.svg";
    } else if (index == 2) {
      return (bottomNavigationViewModel.selectedIndex == index) ? "ic_shop_select.svg" : "ic_shop.svg";
    } else if (index == 3) {
      return (bottomNavigationViewModel.selectedIndex == index) ? "ic_history_select.svg" : "ic_history.svg";
    } else if (index == 4) {
      return (bottomNavigationViewModel.selectedIndex == index) ? "ic_menu_select.svg" : "ic_menu.svg";
    }
    return "";
  }

  String getMenuName(int index) {
    if (index == 0) {
      return buildTranslate(context, 'home');
    } else if (index == 1) {
      return buildTranslate(context, 'recharge');
    } else if (index == 2) {
      return buildTranslate(context, 'shop');
    } else if (index == 3) {
      return buildTranslate(context, 'history');
    } else if (index == 4) {
      return buildTranslate(context, 'menu');
    }
    return "";
  }
}
