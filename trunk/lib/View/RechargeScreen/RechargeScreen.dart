import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/Custom/ButtonView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Helper/NavigatorHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../Custom/CustomAppBar.dart';
import 'RechargePlanScreen.dart';
import 'RechargeViewModel.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> with SingleTickerProviderStateMixin {
  RechargeViewModel rechargeViewModel = RechargeViewModel();

  @override
  void initState() {
    super.initState();
    rechargeViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => rechargeViewModel,
      child: Consumer<RechargeViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(top: 62, left: 25, bottom: 20),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: buildTranslate(context, 'select'),
                            style: Fonts.textStyleRegular.copyWith(color: AppColor.appBlackColor, fontSize: 18,),
                          ),
                          WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                          TextSpan(
                            text: buildTranslate(context, 'eSim'),
                            style: Fonts.textStyleBold.copyWith(color: AppColor.appPrimaryLightColor, fontSize: 18),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: commonBackGround(
              context, Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: ShapeDecoration(
                          // color: AppColor.appBlackColor,
                          color: AppColor.appColorCommonContainer,
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
                            margin: const EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 20),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return rechargeItem(index: index, isActivePlan: index == 0);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return CommonWidget.getFieldSpacer(height: 20);
                              },
                            )),
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

  Widget rechargeItem({int index = 0, bool? isActivePlan = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: ShapeDecoration(
            color: AppColor.appWhiteColor,
            shape: SmoothRectangleBorder(
                side: BorderSide(width: 1, color: AppColor.appBlackColor),
                borderRadius: const SmoothBorderRadius.all(
                  SmoothRadius(
                    cornerRadius: 12,
                    cornerSmoothing: 0.5,
                  ),
                )),
          ),
          child: GestureDetector(
            onTap: () {
              NavigatorHelper().add(const RechargePlanScreen());
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: AppColor.appWhiteColor, width: 0.5),
                color: AppColor.appWhiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsHelper.getSVGIcon(
                          "ic_dummy_flag.svg",
                        ),
                        height: 25,
                        width: 25,
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                      Expanded(
                        child: Text(
                          "Mexico",
                          style: Fonts.textStyleSemiBold.copyWith(fontSize: 16, color: AppColor.appPrimaryColor),
                        ),
                      ),
                      Text(
                        "AT&T",
                        style: Fonts.textStyleBold.copyWith(
                          fontSize: 17,
                          color: AppColor.textGray
                        ),
                      ),
                     
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 10),
                  Text(
                    "+52 999-999-999",
                    style: Fonts.textStyleSemiBold
                        .copyWith(fontSize: 17, color: AppColor.appBlackColor, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
