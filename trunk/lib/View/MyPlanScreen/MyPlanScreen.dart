import 'dart:io';

import 'package:Symbaa/Helper/NavigatorHelper.dart';
import 'package:Symbaa/Style/AppTheme.dart';
import 'package:Symbaa/Utils/CommonBackground.dart';
import 'package:Symbaa/View/FAQ/FAQViewModel.dart';
import 'package:Symbaa/View/ProfileScreen/ProdileViewModel.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Helper/AssetsHelper.dart';
import '../../Localization/languageSettings.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';
import '../../Utils/Constants.dart';
import '../Custom/DashedLinePainter.dart';
import 'MyPlanViewModel.dart';

class MyPlanScreen extends StatefulWidget {
  const MyPlanScreen({super.key});

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> with SingleTickerProviderStateMixin {
  MyPlanViewModel myPlanViewModel = MyPlanViewModel();

  @override
  void initState() {
    super.initState();
    myPlanViewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => myPlanViewModel,
      child: Consumer<MyPlanViewModel>(
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
                          buildTranslate(context, 'myPlans'),
                          style: Fonts.textStyleBold.copyWith(color: AppColor.appBlackColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body:commonBackGround(
              context, Stack(
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
                              margin:  EdgeInsets.only(top: 20, left: 20, right: 20,bottom: Platform.isIOS ? 50 : 10),
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return planItem(index: index, isActivePlan: index == 0);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return CommonWidget.getFieldSpacer(height: 20);
                                },
                              )),
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

  Widget planItem({int index = 0, bool? isActivePlan = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (isActivePlan ?? false) ? buildTranslate(context, 'activePlans') : buildTranslate(context, 'addOns'),
          style: Fonts.textStyleRegular.copyWith(fontSize: 18, color: AppColor.appWhiteColor),
        ),
        CommonWidget.getFieldSpacer(height: 15),
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
            onTap: () {},
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                      Expanded(
                        child: Text(
                          (isActivePlan ?? false) ? "\$65.00" : "\$10.00",
                          style: Fonts.textStyleBold.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(
                          AssetsHelper.getSVGIcon(
                            "ic_dummy_flag.svg",
                          ),
                          height: 25,
                          width: 25,
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 10),
                      Text(
                        "Mexico",
                        style: Fonts.textStyleSemiBold.copyWith(fontSize: 14, color: AppColor.appPrimaryColor),
                      ),
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 15),
                  Text(
                    "${buildTranslate(context, 'expiresOn')} 07 Jul, 2024 09:51 PM",
                    style: Fonts.textStyleRegular.copyWith(fontSize: 14, color: AppColor.textGray),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  CustomPaint(
                    size: const Size(double.infinity, 0.5), // Width of the dashed line
                    painter: DashedLinePainter(
                      dashWidth: 2.7,
                      dashSpace: 3.5,
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: isActivePlan ?? false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AssetsHelper.getSVGIcon(
                              'ic_call.svg',
                            ),
                            height: 25,
                            width: 25,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    buildTranslate(context, 'calls'),
                                    style: Fonts.textStyleRegular.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 6),
                                  Text(
                                    buildTranslate(context, 'unlimitedCallsToAllNetwork'),
                                    style: Fonts.textExtraBold.copyWith(
                                      fontSize: 15.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isActivePlan ?? false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AssetsHelper.getSVGIcon(
                              'ic_sms.svg',
                            ),
                            height: 25,
                            width: 25,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    buildTranslate(context, 'sms'),
                                    style: Fonts.textStyleRegular.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(height: 6),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "483 ${buildTranslate(context, "sms")}",
                                        style: Fonts.textStyleBold.copyWith(fontSize: 16),
                                      ),
                                      WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                      TextSpan(
                                        text: "${buildTranslate(context, "leftOf")} 700 ${buildTranslate(context, "sms")}",
                                        style: Fonts.textStyleRegular.copyWith(fontSize: 16),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsHelper.getSVGIcon(
                          'ic_data.svg',
                        ),
                        height: 25,
                        width: 25,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buildTranslate(context, 'data'),
                                style: Fonts.textStyleRegular.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 6),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "10.19 GB",
                                    style: Fonts.textStyleBold.copyWith(fontSize: 16),
                                  ),
                                  WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                                  TextSpan(
                                    text: (isActivePlan ?? false)
                                        ? "${buildTranslate(context, "leftOf")} 20 GB"
                                        : buildTranslate(context, "additionalData"),
                                    style: Fonts.textStyleRegular.copyWith(fontSize: 16),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
