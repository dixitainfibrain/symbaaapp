import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/AppGlobal.dart';
import 'package:Symbaa/Utils/Constants.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:Symbaa/View/FAQ/FAQScreen.dart';
import 'package:Symbaa/View/MenuScreen/MenuViewModel.dart';
import 'package:Symbaa/View/PrivacyPolicy/PrivacyPolicyScreen.dart';
import 'package:Symbaa/View/ProfileScreen/ProfileScreen.dart';
import 'package:Symbaa/View/Support/SupportScreen.dart';
import 'package:Symbaa/View/TermsAndCondition/TermsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../BottomNavigationScreen/BottomNavigationScreen.dart';
import '../HistoryScreen/HistoryScreen.dart';
import '../MyPlanScreen/MyPlanScreen.dart';
import '../RechargeScreen/RechargeScreen.dart';
import '../ShopScreen/ShopScreen.dart';
import 'MenuScreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {
  MenuViewModel menuViewModel = MenuViewModel();

  @override
  void initState() {
    super.initState();
    menuViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => menuViewModel,
      child: Consumer<MenuViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Hero(
                  tag: heroProfile,
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 60, left: 25),
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: AppColor.appCurveBorderColor, width: 0.5),
                              color: AppColor.appBlackColor,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(6),
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: AppColor.appCurveBorderColor, width: 0.5),
                                    color: AppColor.appWhiteColor,
                                  ),
                                  child: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon("ic_profile_fill.svg"),
                                    color: AppColor.appBlackColor,
                                  ),
                                ),
                                CommonWidget.getFieldSpacer(width: 5),
                                Text(
                                  buildTranslate(context, 'myProfile'),
                                  style: Fonts.textStyleBold.copyWith(color: AppColor.appWhiteColor, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppColor.appThemeBG,
                image: const DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/img_theme_bg.png'),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 130, left: 25, right: 25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        buildTranslate(context, 'services'),
                        style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 20),
                      ),
                      CommonWidget.getFieldSpacer(height: 15),
                      Column(
                        children: [
                          SizedBox(
                            height: 82,
                            child: ListView.separated(
                              itemCount: menuViewModel.listCard.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 82,
                                    width: (MediaQuery.of(context).size.width / 3) - 30,
                                    child: cardItem(index),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 20,
                                );
                              },
                            ),
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: menuViewModel.listMenu.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return listItem(index);
                            },
                          ),
                          CommonWidget.getFieldSpacer(height: 80),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${buildTranslate(context, 'appVersion')}: ${menuViewModel.appVersion}",
                              textAlign: TextAlign.center,
                              style: Fonts.textStyleRegular.copyWith(color: AppColor.appBlackColor.withOpacity(0.5), fontSize: 14),
                            ),
                          ),
                          CommonWidget.getFieldSpacer(height: 40),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cardItem(int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          NavigatorHelper.removeAllAndOpen(BottomNavigationScreen(
            selectedIndex: 2,
          ));
        } else if (index == 1) {
          NavigatorHelper.removeAllAndOpen(BottomNavigationScreen(
            selectedIndex: 1,
          ));
        } else {
          NavigatorHelper.removeAllAndOpen(BottomNavigationScreen(
            selectedIndex: 3,
          ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColor.appWhiteColor, width: 0.5),
          color: AppColor.appWhiteColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(
                AssetsHelper.getSVGIcon(menuViewModel.listCard[index].icon ?? ''),
              ),
            ),
            CommonWidget.getFieldSpacer(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      buildTranslate(context, menuViewModel.listCard[index].name ?? ''),
                      style: Fonts.textStyleRegular.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    AssetsHelper.getSVGIcon("ic_forward.svg"),
                    height: 8,
                    width: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(int index) {
    return GestureDetector(
      onTap: () {
        manageNavigation(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 1,
          ),
          CommonWidget.getFieldSpacer(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AssetsHelper.getSVGIcon(menuViewModel.listMenu[index].icon ?? ''),
                height: 22,
              ),
              CommonWidget.getFieldSpacer(width: 10),
              Expanded(
                child: Text(
                  buildTranslate(context, menuViewModel.listMenu[index].name ?? ''),
                  style: Fonts.textStyleBold.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  manageNavigation(index);
                },
                child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon("ic_forward.svg"),
                ),
              ),
            ],
          ),
          CommonWidget.getFieldSpacer(height: 20),
        ],
      ),
    );
  }

  void manageNavigation(int index){
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyPlanScreen()));
    } else if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FAQScreen()));
    } else if (index == 2) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SupportScreen()));
    } else if (index == 3) {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermsScreen()));
    } else if (index == 4) {
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
    }
  }
}
