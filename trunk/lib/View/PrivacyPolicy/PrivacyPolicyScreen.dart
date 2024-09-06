import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/View/FAQ/FAQViewModel.dart';
import 'package:Symbaa/View/ProfileScreen/ProdileViewModel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import 'PrivacyViewModel.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyViewModelState();
}

class _PrivacyViewModelState extends State<PrivacyPolicyScreen> with SingleTickerProviderStateMixin {
  PrivacyViewModel privacyViewModel = PrivacyViewModel();


  @override
  void initState() {
    super.initState();
    privacyViewModel.init(context);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => privacyViewModel,
      child: Consumer<PrivacyViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    NavigatorHelper.remove();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 60, left: 25),
                    width: 140,
                    height: 38,
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            height: 10,
                            width: 10,
                            AssetsHelper.getSVGIcon("ic_back.svg"),
                            color: AppColor.appBlackColor,
                          ),
                        ),
                        CommonWidget.getFieldSpacer(width: 10),
                        Text(
                          buildTranslate(context, 'privacyPolicy'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                        ),
                      ],
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
              child: Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Hero(
                      tag: heroMenuItem,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: ShapeDecoration(
                            color: AppColor.appBlackColor,
                            shape: SmoothRectangleBorder(
                                side: BorderSide(width: 1, color: AppColor.appBlackColor),
                                borderRadius: const SmoothBorderRadius.only(
                                    topLeft: SmoothRadius(
                                      cornerRadius: 25,
                                      cornerSmoothing: 0.5,
                                    ),
                                    topRight: SmoothRadius(
                                      cornerRadius: 25,
                                      cornerSmoothing: 0.5,
                                    ))),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
